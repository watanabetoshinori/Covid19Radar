//
//  AppConstants.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/06.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct AppConstants {

    static let numberOfGroup = 86400

    static let outOfDateDays = -14

    static let cacheTimeout = 60

    static let activeRollingPeriod = 144

    static let maxErrorCount = 3

    static let maxDiagnosisUidCount = 8

    static let positiveRegex = #"\b[0-9]{8}\b"#

}
