//
//  Configuration.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct Configuration: Codable {

    var minimumRiskScore: Double = 4

    var attenuationWeight: Double = 50

    var transmissionWeight: Double = 50

    var durationWeight: Double = 50

    var daysSinceLastExposureWeight: Double = 50

    var transmissionRiskScores = [4, 4, 4, 4, 4, 4, 4, 4]

    var attenuationScores = [4, 4, 4, 4, 4, 4, 4, 4]

    var durationScores = [4, 4, 4, 4, 4, 4, 4, 4]

    var daysSinceLastExposureScores = [4, 4, 4, 4, 4, 4, 4, 4]

    var durationAtAttenuationThresholds: [Int]? = [50, 70]

    enum CodingKeys: String, CodingKey {
        case minimumRiskScore = "MinimumRiskScore"
        case attenuationWeight = "AttenuationWeight"
        case transmissionWeight = "TransmissionWeight"
        case durationWeight = "DurationWeight"
        case daysSinceLastExposureWeight = "DaysSinceLastExposureWeight"
        case transmissionRiskScores = "TransmissionRiskScores"
        case attenuationScores = "AttenuationScores"
        case durationScores = "DurationScores"
        case daysSinceLastExposureScores = "DaysSinceLastExposureScores"
        case durationAtAttenuationThresholds = "DurationAtAttenuationThresholds"
    }

}
