//
//  PositiveDiagnosisState.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct PositiveDiagnosisState: Codable {

    var diagnosisUid: String

    var diagnosisDate: Date

    var shared: Bool

}
