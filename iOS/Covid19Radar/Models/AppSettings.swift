//
//  AppSettings.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct AppSettings: Codable {

    var appVersion: String

    var apiSecret: String

    var apiUrlBase: String

    var supportedRegions: String

    var blobStorageContainerName: String

    var androidSafetyNetApiKey: String

    var cdnUrlBase: String

    var licenseUrl: String

    var appStoreUrl: String

    var googlePlayUrl: String

    var supportEmail: String

    var supportedRegionList: [String] {
        supportedRegions.components(separatedBy: ";")
    }

}
