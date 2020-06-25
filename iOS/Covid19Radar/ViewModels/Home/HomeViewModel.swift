//
//  HomeViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    var startDate = "2020/06/15"

    var pastDate = "60"

    var exposureSummaryCount: Int = LocalStore.shared.exposureSummaries.count

    private var cancellables = [AnyCancellable]()

    init() {
        let notification = Notification.Name(rawValue: "LocalStoreExposureSummariesDidChange")
        NotificationCenter.default.publisher(for: notification).sink { _ in
            self.exposureSummaryCount = LocalStore.shared.exposureSummaries.count
        }
        .store(in: &cancellables)
    }

}
