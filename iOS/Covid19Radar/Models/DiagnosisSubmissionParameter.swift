//
//  DiagnosisSubmissionParameter.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/06.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct DiagnosisSubmissionParameter: Codable {

    var userUuid: String

    var keys: [Key]

    var regions: [String]

    var platform: String

    var deviceVerificationPayload: String?

    var appPackageName: String

    var verificationPayload: String

    var padding: String

    struct Key: Codable {
        var keyData: String

        var rollingStartNumber: UInt

        var rollingPeriod: UInt

        var transmissionRisk: Int

        var isValid: Bool {
            if keyData.isEmpty {
                return false
            }
            if rollingPeriod != 0, rollingPeriod != AppConstants.activeRollingPeriod {
                return false
            }

            if rollingStartNumber != 0,
                rollingStartNumber < UInt(Calendar.current.date(byAdding: .day, value: AppConstants.outOfDateDays, to: Date())!.timeIntervalSince1970 / 600) {
                return false
            }

            return true
        }

    }

}
