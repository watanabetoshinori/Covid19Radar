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

    @Published var isOnboarded = UserData.shared.isOnboarded

    @Published var showLoading = false

    private var cancellables = [AnyCancellable]()

    init() {
        NotificationCenter.default.publisher(for: .init(rawValue: "LocalStoreIsOnboardedDidChange")).sink { _ in
            self.isOnboarded = UserData.shared.isOnboarded
        }
        .store(in: &cancellables)

        LoadingDialog.shared.showLoadingPublisher
            .sink { _ in
                self.showLoading = true
            }
            .store(in: &cancellables)

        LoadingDialog.shared.hideLoadingPublisher
            .receive(on: RunLoop.main)
            .sink { _ in
                self.showLoading = false
            }
            .store(in: &cancellables)
    }

}
