//
//  AppSettings.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct AppSettings: Codable {

    static var shared: AppSettings = {
        guard let fileURL = Bundle.main.url(forResource: "settings", withExtension: "json"),
            let data = try? Data(contentsOf: fileURL),
            let settings = try? JSONDecoder().decode(AppSettings.self, from: data) else {
            fatalError()
        }

        return settings
    }()

    var appVersion: String

    var apiSecret: String

    var apiUrlBase: String

    var supportedRegions: String

    var blobStorageContainerName: String

    var cdnUrlBase: String

    var licenseUrl: String

    var appStoreUrl: String

    var supportEmail: String

    var supportedRegionList: [String] {
        supportedRegions.components(separatedBy: ";")
    }

}
