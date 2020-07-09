//
//  DeveloperViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class DeveloperViewModel: ObservableObject {

    @Published var isOnboarded = UserData.shared.isOnboarded

    func simulateExposure() {
        let info = UserExposureInfo(timeStamp: Date() - TimeInterval.random(in: 1...13) * 24 * 60 * 60,
                                    duration: Int.random(in: 15...60) * 60,
                                    attenuationValue: Int.random(in: 50...100),
                                    totalRiskScore: Int.random(in: 1...10),
                                    transmissionRiskLevel: UserExposureInfo.UserRiskLevel(rawValue: Int.random(in: 1...7))!)

        UserData.shared.exposureInformation.append(info)

        let summary = UserExposureSummary(daysSinceLastExposure: 0,
                                         matchedKeyCount: 1,
                                         highestRiskScore: info.totalRiskScore,
                                         attenuationDurations: [info.duration],
                                         summationRiskScore: info.totalRiskScore)

        UserData.shared.exposureSumary = summary
    }

    func resetOnboarding() {
        UserData.shared.isOnboarded = false
    }

    func resetLocalExposures() {
        UserData.shared.exposureSumary = nil
        UserData.shared.exposureInformation = []
    }

}
