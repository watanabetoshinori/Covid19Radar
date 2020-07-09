//
//  RegisterResult.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/06.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct RegisterResult: Codable {

    var userUuid: String

    var secret: String

    var jumpConsistentSeed: Int

}
