//
//  SettingsViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class SettingsViewModel: ObservableObject {

    @Published var isPresented = false

    @Published var isExposureEnabled = true

    @Published var isNotificationEnabled = true

    var version = "1.1"

    func reset() {

    }

}
