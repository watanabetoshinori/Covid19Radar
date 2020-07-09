//
//  MockExposureNotificationHandler.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import ExposureNotification

class MockExposureNotificationHandler: ExposureNotificationHandler {

    var userExplanation =  NSLocalizedString("LocalNotificationDescription", comment: "")

    func registerUser(completionHandler: @escaping (Result<RegisterResult, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let result = RegisterResult(userUuid: "dummy uuid",
                                        secret: "dummy secret",
                                        jumpConsistentSeed: 999)
            completionHandler(.success(result))
        }
    }

    func getConfiguration(completionHandler: @escaping (Configuration) -> Void) {
        // In a real implementation, get json data from a remote server
        let dataFromServer =
        """
        {
            "MinimumRiskScore": 1,
            "AttenuationWeight": 50,
            "TransmissionWeight": 50,
            "DurationWeight": 50,
            "DaysSinceLastExposureWeight": 50,
            "TransmissionRiskScores": [7, 7, 7, 7, 7, 7, 7, 7],
            "AttenuationScores": [0, 0, 0, 0, 1, 1, 1, 1],
            "DurationScores": [0, 0, 0, 0, 1, 1, 1, 1],
            "DaysSinceLastExposureScores": [1,1, 1, 1, 1, 1, 1, 1],
            "DurationAtAttenuationThresholds": [50, 70]
        }
        """
        .data(using: .utf8)!

        do {
            let configuration = try JSONDecoder().decode(Configuration.self, from: dataFromServer)
            completionHandler(configuration)
        } catch {
            print(error)
            completionHandler(Configuration())
        }
    }

    func fetchExposureKeyBatchFilesFromServer(submitBatches: @escaping ([String], @escaping () -> Void) -> Void, completionHandler: @escaping () -> Void) {
        // In a real implementation, download zip file from a remote server
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completionHandler()
        }
    }

    func exposureDetected(summary: ENExposureDetectionSummary, getExposureInfo: @escaping (@escaping ([ENExposureInfo]) -> Void) -> Void, completionHandler: @escaping  () -> Void) {
        let exposureSummary = UserExposureSummary(daysSinceLastExposure: summary.daysSinceLastExposure,
                                                  matchedKeyCount: Int(summary.matchedKeyCount),
                                                  highestRiskScore: summary.metadata?["maximumRiskScoreFullRange"] as? Int ?? 0,
                                                  attenuationDurations: summary.attenuationDurations.compactMap { Int(truncating: $0) },
                                                  summationRiskScore: summary.metadata?["riskScoreSumFullRange"] as? Int ?? 0)

        UserData.shared.exposureSumary = exposureSummary

        getExposureInfo { information in
            information.forEach { info in
                let exposureInfo = UserExposureInfo(timeStamp: info.date,
                                                    duration: Int(info.duration),
                                                    attenuationValue: Int(info.attenuationValue),
                                                    totalRiskScore: Int(info.totalRiskScore),
                                                    transmissionRiskLevel: UserExposureInfo.UserRiskLevel(rawValue: Int(info.transmissionRiskLevel))!)
                UserData.shared.exposureInformation.append(exposureInfo)
            }

            completionHandler()
        }
    }

    func uploadSelfExposureKeysToServer(temporaryExposureKeys: [ENTemporaryExposureKey], completionHandler: @escaping (Error?) -> Void) {
        guard let pendingDiagnosis = UserData.shared.positiveDiagnoses
                                .filter({ $0.shared == false })
                                .sorted(by: { $0.diagnosisDate < $1.diagnosisDate })
                                .first else {
            completionHandler(CD19Error.invalidOperation)
            return
        }

        let keys = temporaryExposureKeys.compactMap({ key in
            DiagnosisSubmissionParameter.Key(keyData: key.keyData.base64EncodedString(),
                                             rollingStartNumber: UInt(key.rollingStartNumber),
                                             rollingPeriod: UInt(key.rollingPeriod),
                                             transmissionRisk: Int(key.transmissionRiskLevel)
            )
        })

        if keys.first(where: { $0.isValid == false }) != nil {
            completionHandler(CD19Error.invalidData)
            return
        }

        if keys.isEmpty {
            completionHandler(CD19Error.invalidData)
            return
        }

        var bytes = [UInt8](repeating: 0, count: Int(Double.random(in: 1024...2048) * 0.75))
        _ = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        let padding = Data(bytes).base64EncodedString()

        let submission = DiagnosisSubmissionParameter(userUuid: UserData.shared.userUuid,
                                                      keys: keys,
                                                      regions: AppSettings.shared.supportedRegionList,
                                                      platform: "iOS",
                                                      deviceVerificationPayload: nil,
                                                      appPackageName: Bundle.main.bundleIdentifier!,
                                                      verificationPayload: pendingDiagnosis.diagnosisUid,
                                                      padding: padding)

        // In a real implementation, submisson would be stored on a remote server
        print(submission)

        UserData.shared.update(diagnoses: pendingDiagnosis)

        completionHandler(nil)
    }

}
