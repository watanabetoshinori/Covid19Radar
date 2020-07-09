//
//  UserExposureSummary.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct UserExposureSummary: Codable {

    var daysSinceLastExposure: Int

    var matchedKeyCount: Int

    var highestRiskScore: Int

    var attenuationDurations: [Int]

    var summationRiskScore: Int

}
