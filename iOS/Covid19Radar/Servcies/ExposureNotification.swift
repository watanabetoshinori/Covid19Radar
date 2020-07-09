//
//  ExposureNotification.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import ExposureNotification
import BackgroundTasks

class ExposureNotification {

    private let backgroundTaskIdentifier = Bundle.main.bundleIdentifier! + ".exposure-notification"

    private let handler: ExposureNotificationHandler

    private var manager: ENManager!

    private var isUpdating = false

    // MARK: - Initializing ExposureNotification

    init(handler: ExposureNotificationHandler) {
        self.handler = handler
    }

    // MARK: - Shared

    func initialize() {
        scheduledFetch()
    }

    private func getManager(completionHandler: @escaping (ENManager) -> Void) {
        if let manager = manager {
            completionHandler(manager)
            return
        }

        manager = ENManager()
        manager.activate { _ in
            completionHandler(self.manager)
        }
    }

    private func getConfiguration(completionHandler: @escaping (ENExposureConfiguration) -> Void) {
        handler.getConfiguration { configuration in
            let exposureConfiguration = ENExposureConfiguration()
            exposureConfiguration.attenuationLevelValues = configuration.attenuationScores as [NSNumber]
            exposureConfiguration.durationLevelValues = configuration.durationScores as [NSNumber]
            exposureConfiguration.daysSinceLastExposureLevelValues = configuration.daysSinceLastExposureScores as [NSNumber]
            exposureConfiguration.transmissionRiskLevelValues = configuration.transmissionRiskScores as [NSNumber]
            exposureConfiguration.attenuationWeight = configuration.attenuationWeight
            exposureConfiguration.daysSinceLastExposureWeight = configuration.daysSinceLastExposureWeight
            exposureConfiguration.durationWeight = configuration.durationWeight
            exposureConfiguration.transmissionRiskWeight = configuration.transmissionWeight
            exposureConfiguration.minimumRiskScore = ENRiskScore(configuration.minimumRiskScore)

            var metadata = [AnyHashable: Any]()
            metadata["minimumRiskScoreFullRange"] = NSNumber(value: configuration.minimumRiskScore)
            if let durationAtAttenuationThresholds = configuration.durationAtAttenuationThresholds {
                metadata["attenuationDurationThresholds"] = durationAtAttenuationThresholds
            }

            exposureConfiguration.metadata = metadata

            completionHandler(exposureConfiguration)
        }
    }

    func scheduledFetch() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundTaskIdentifier, using: .main) { [weak self] task in
            guard let self = self else {
                task.setTaskCompleted(success: false)
                return
            }

            if self.isUpdating {
                task.setTaskCompleted(success: false)
                return
            }

            self.isUpdating = true

            self.updateKeysFromServer { result in
                task.setTaskCompleted(success: result)
                self.isUpdating = false
            }

            task.expirationHandler = {
                task.setTaskCompleted(success: false)
                self.isUpdating = false
            }

            self.scheduleBackgroundTask()
        }

        scheduleBackgroundTask()
    }

    private func scheduleBackgroundTask() {
        guard ENManager.authorizationStatus == .authorized else {
            return
        }

        let taskRequest = BGProcessingTaskRequest(identifier: backgroundTaskIdentifier)
        taskRequest.requiresNetworkConnectivity = true

        do {
            try BGTaskScheduler.shared.submit(taskRequest)
        } catch {
            print("There was an error submitting the background task: \(error)")
        }
    }

    func start(completionHandler: @escaping (Error?) -> Void) {
        getManager { manager in
            manager.setExposureNotificationEnabled(true) { error in
                completionHandler(error)
            }
        }
    }

    func stop(completionHandler: @escaping (Error?) -> Void) {
        getManager { manager in
            manager.setExposureNotificationEnabled(false) { error in
                completionHandler(error)
            }
        }
    }

    func isEnabled(completionHandler: @escaping (Bool) -> Void) {
        getManager { manager in
            completionHandler(manager.exposureNotificationEnabled)
        }
    }

    func submitSelfDiagnosis(completionHandler: @escaping (Error?) -> Void) {
        getSelfTemporaryExposureKeys { keys in
            self.handler.uploadSelfExposureKeysToServer(temporaryExposureKeys: keys) { error in
                completionHandler(error)
            }
        }
    }

    func updateKeysFromServer(completionHandler: @escaping (Bool) -> Void) {
        var processedAnyFiles = false

        handler.fetchExposureKeyBatchFilesFromServer(submitBatches: { downloadedFiles, completionHandler in
            if downloadedFiles.isEmpty {
                completionHandler()
                return
            }

            self.detectExposures(keyFiles: downloadedFiles) { summary, info in
                if summary.matchedKeyCount == 0 {
                    processedAnyFiles = true
                    completionHandler()
                    return
                }

                self.handler.exposureDetected(summary: summary, getExposureInfo: info) {
                    processedAnyFiles = true
                    completionHandler()
                }
            }

        }) {
            completionHandler(processedAnyFiles)
        }
    }

    private func detectExposures(keyFiles: [String], completionHandler: @escaping (ENExposureDetectionSummary, @escaping (@escaping ([ENExposureInfo]) -> Void) -> Void) -> Void) {
        // TODO: Not implemented yet
    }

    private func getSelfTemporaryExposureKeys(completionHandler: @escaping ([ENTemporaryExposureKey]) -> Void) {
        getManager { manager in
            manager.getDiagnosisKeys { (keys, _) in
                guard let keys = keys else {
                    completionHandler([])
                    return
                }

                completionHandler(keys)
            }
        }
    }

    func getStatus(completionHandler: @escaping (ENStatus) -> Void) {
        getManager { manager in
            completionHandler(manager.exposureNotificationStatus)
        }
    }

}
