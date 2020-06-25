//
//  DeveloperViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class DeveloperViewModel: ObservableObject {

    @Published var isOnboarded = LocalStore.shared.isOnboarded

    func simulateExposureSummary() {
        let exposure = ExposureSummary(date: Date() - TimeInterval.random(in: 1...4) * 24 * 60 * 60,
                                       count: Int.random(in: 1...4))
        LocalStore.shared.exposureSummaries.append(exposure)
    }

    func resetOnboarding() {
        LocalStore.shared.isOnboarded = false
    }

    func resetLocalExposureSummaries() {
        LocalStore.shared.exposureSummaries = []
    }

    func exit() {
        abort()
    }

}
