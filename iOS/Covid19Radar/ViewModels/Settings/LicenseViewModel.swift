//
//  LicenseViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class LicenseViewModel: ObservableObject {

    var licenseURL = ""

    init() {
        guard let fileURL = Bundle.main.url(forResource: "settings", withExtension: "json"),
            let data = try? Data(contentsOf: fileURL),
            let setttngs = try? JSONDecoder().decode(AppSettings.self, from: data) else {
            return
        }

        licenseURL = setttngs.licenseUrl
    }

}
