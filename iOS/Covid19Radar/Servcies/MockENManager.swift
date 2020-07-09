//
//  MockENManager.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/06.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import UIKit
import ExposureNotification

typealias ENGetDiagnosisKeysHandler = ([ENTemporaryExposureKey]?, Error?) -> Void

typealias ENDetectExposuresHandler = (ENExposureDetectionSummary?, Error?) -> Void

typealias ENGetExposureInfoHandler = ([ENExposureInfo]?, Error?) -> Void

// MARK: - Essential

class ENManager: NSObject {

    // MARK: - Activating the Manager

    func activate(completionHandler: @escaping ENErrorHandler) {
        if exposureNotificationStatus == .unknown {
            if exposureNotificationEnabled {
                UserDefaults.standard.set(ENStatus.active.rawValue, forKey: "ENStatus")
            } else {
                UserDefaults.standard.set(ENStatus.disabled.rawValue, forKey: "ENStatus")
            }
        }
        UserDefaults.standard.synchronize()

        dispatchQueue.async {
            completionHandler(nil)
        }
    }

    // swiftlint:disable line_length
    func setExposureNotificationEnabled(_ enabled: Bool, completionHandler: @escaping ENErrorHandler) {
        if enabled {
            if exposureNotificationEnabled {
                completionHandler(nil)
                return
            }

            let enableAction = UIAlertAction(title: "Enable", style: .default, handler: { _ in
                UserDefaults.standard.set(ENAuthorizationStatus.authorized.rawValue, forKey: "ENAuthorizationStatus")
                UserDefaults.standard.set(ENStatus.active.rawValue, forKey: "ENStatus")
                UserDefaults.standard.set(true, forKey: "exposureNotificationEnabled")
                UserDefaults.standard.synchronize()

                self.dispatchQueue.async {
                    completionHandler(nil)
                }
            })
            let disableAction = UIAlertAction(title: "Don't Enable", style: .cancel, handler: { _ in
                UserDefaults.standard.set(ENAuthorizationStatus.notAuthorized.rawValue, forKey: "ENAuthorizationStatus")
                UserDefaults.standard.set(ENStatus.disabled.rawValue, forKey: "ENStatus")
                UserDefaults.standard.set(false, forKey: "exposureNotificationEnabled")
                UserDefaults.standard.synchronize()

                self.dispatchQueue.async {
                    completionHandler(nil)
                }
            })

            let alertController = UIAlertController(title: "Enable COVID-19 Exposure Loagging and Notifications",
                                                    message: #"Your iPhone can securely collect and share random IDs with nearby devices. The app can user these IDs to notify you if you may have been esposed to COVID-19. The date, duration, and signal strength of an eposure will be shared with "COVID-19 Contact App""#,
                                                    preferredStyle: .alert)
            alertController.addAction(disableAction)
            alertController.addAction(enableAction)
            alertController.preferredAction = enableAction

            present(alertController)

        } else {
            UserDefaults.standard.set(ENAuthorizationStatus.notAuthorized.rawValue, forKey: "ENAuthorizationStatus")
            UserDefaults.standard.set(ENStatus.disabled.rawValue, forKey: "ENStatus")
            UserDefaults.standard.set(false, forKey: "exposureNotificationEnabled")
            UserDefaults.standard.synchronize()

            dispatchQueue.async {
                completionHandler(nil)
            }
        }
    }

    // MARK: - Obtaining Exposure Information

    func detectExposures(configuration: ENExposureConfiguration, diagnosisKeyURLs: [URL], completionHandler: @escaping ENDetectExposuresHandler) -> Progress {
        let progress = Progress(totalUnitCount: Int64(diagnosisKeyURLs.count))

        DispatchQueue.global().async {
            let summary = ENExposureDetectionSummary()
            summary.daysSinceLastExposure = 0
            summary.matchedKeyCount = 1
            summary.maximumRiskScore = 1
            summary.attenuationDurations = [0]
            summary.metadata = nil

            self.dispatchQueue.async {
                completionHandler(summary, nil)
            }
        }

        return progress
    }

    func getExposureInfo(summary: ENExposureDetectionSummary, userExplanation: String, completionHandler: @escaping ENGetExposureInfoHandler) -> Progress {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents([.day, .month, .year], from: Date())//.date
        let today = calendar.date(from: component)!

        let info = ENExposureInfo()
        info.attenuationDurations = [0]
        info.attenuationValue = ENAttenuation(0)
        info.date = calendar.date(byAdding: .day, value: -1, to: today)
        info.duration = 900
        info.totalRiskScore = ENRiskScore(0)
        info.transmissionRiskLevel = ENRiskLevel(0)
        info.metadata = nil

        dispatchQueue.async {
            completionHandler([info], nil)
        }

        return Progress(totalUnitCount: 0)
    }

    // MARK: - Obtaining Exposure Keys

    func getDiagnosisKeys(completionHandler: @escaping ENGetDiagnosisKeysHandler) {
        let enableAction = UIAlertAction(title: "Share", style: .default, handler: { _ in
            self.dispatchQueue.async {
                completionHandler(Array(self.exposureKeys.dropFirst()), nil)
            }
        })
        let disableAction = UIAlertAction(title: "Don't Share", style: .cancel, handler: { _ in
            self.dispatchQueue.async {
                completionHandler([], nil)
            }
        })

        let alertController = UIAlertController(title: "Share your random IDs with Esposure Notifications?",
                                                message: "Your random IDs from the past 14 days will be used to help notify others that you've been near about potential exposure to COVID-19.\n\nYouridentity won't be shared with other people.",
                                                preferredStyle: .alert)
        alertController.addAction(disableAction)
        alertController.addAction(enableAction)
        alertController.preferredAction = enableAction

        present(alertController)
    }

    func getTestDiagnosisKeys(completionHandler: @escaping ENGetDiagnosisKeysHandler) {
        dispatchQueue.async {
            completionHandler(self.exposureKeys, nil)
        }
    }

    private var exposureKeys: [ENTemporaryExposureKey] {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents([.day, .month, .year], from: Date())//.date
        let today = calendar.date(from: component)!

        var keys = [ENTemporaryExposureKey]()

        (0..<14).forEach { (value) in
            guard let startTime = calendar.date(byAdding: .day, value: -value, to: today)?.timeIntervalSince1970 else {
                return
            }

            let key = ENTemporaryExposureKey()
            key.keyData = withUnsafeBytes(of: UUID().uuid, { Data($0) })
            key.rollingPeriod = 144
            key.rollingStartNumber = ENIntervalNumber(startTime / (60 * 10))
            key.transmissionRiskLevel = 0

            keys.append(key)
        }

        return keys
    }

    // MARK: - Configuring the Manager

    @objc var exposureNotificationStatus: ENStatus {
        ENStatus(rawValue: UserDefaults.standard.integer(forKey: "ENStatus")) ?? .unknown
    }

    @objc var exposureNotificationEnabled: Bool {
        UserDefaults.standard.bool(forKey: "exposureNotificationEnabled")
    }

    class var authorizationStatus: ENAuthorizationStatus {
        ENAuthorizationStatus(rawValue: UserDefaults.standard.integer(forKey: "ENAuthorizationStatus")) ?? .unknown
    }

    var dispatchQueue: DispatchQueue = .main

    // MARK: - Invalidating the Manager

    func invalidate() {

    }

    var invalidationHandler: (() -> Void)?

    private func present(_ alertController: UIViewController) {
        var viewController = UIApplication.shared.windows.first!.rootViewController!
        while viewController.presentedViewController != nil {
            viewController = viewController.presentedViewController!
        }
        viewController.present(alertController, animated: true, completion: nil)
    }

}

// MARK: - Exposure

class ENExposureDetectionSummary: NSObject {

    var attenuationDurations: [NSNumber]!

    var daysSinceLastExposure: Int!

    var matchedKeyCount: UInt64!

    var maximumRiskScore: ENRiskScore!

    var metadata: [AnyHashable: Any]?

}

class ENExposureInfo: NSObject {

    var attenuationDurations: [NSNumber]!

    var attenuationValue: ENAttenuation!

    var date: Date!

    var duration: TimeInterval!

    var metadata: [AnyHashable: Any]?

    var totalRiskScore: ENRiskScore!

    var transmissionRiskLevel: ENRiskLevel!

}
