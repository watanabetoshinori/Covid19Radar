//
//  ContentViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {

    @Published var isCollapsed = true

    @Published var selectedIndex = 0

    @Published var isOnboarded = LocalStore.shared.isOnboarded

    private var cancellables = [AnyCancellable]()

    init() {
        let notification = Notification.Name(rawValue: "LocalStoreIsOnboardedDidChange")
        NotificationCenter.default.publisher(for: notification).sink { _ in
            self.isOnboarded = LocalStore.shared.isOnboarded
        }
        .store(in: &cancellables)
    }

}
