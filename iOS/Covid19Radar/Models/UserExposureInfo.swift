//
//  UserExposureInfo.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct UserExposureInfo: Codable {

    enum UserRiskLevel: Int, Codable {
        case invalid = 0
        case lowest
        case low
        case medium
        case mediumHigh
        case high
        case veryHigh
        case highest
    }

    var timeStamp: Date

    var duration: Int

    var attenuationValue: Int

    var totalRiskScore: Int

    var transmissionRiskLevel: UserRiskLevel

}
