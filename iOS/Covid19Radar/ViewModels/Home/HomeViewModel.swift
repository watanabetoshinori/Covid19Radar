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

    var exposureNotification: ExposureNotification

    var startDate = ""

    var pastDate = ""

    var exposureCount: Int = UserData.shared.exposureInformation.count

    private var cancellables = [AnyCancellable]()

    init(exposureNotification: ExposureNotification) {
        self.exposureNotification = exposureNotification

        let formatter = DateFormatter()
        formatter.dateStyle = .full
        startDate = formatter.string(from: UserData.shared.startDateTime)

        let daySpan = Calendar.current.dateComponents([.day], from: UserData.shared.startDateTime, to: Date()).day ?? 0
        pastDate = String(describing: daySpan)

        NotificationCenter.default.publisher(for: .init(rawValue: "LocalStoreExposureInformationDidChange")).sink { _ in
            self.exposureCount = UserData.shared.exposureInformation.count
        }
        .store(in: &cancellables)
    }

    func appear() {
        exposureNotification.start { error in
            if let error = error {
                print(error)
                return
            }

            self.exposureNotification.updateKeysFromServer(completionHandler: { _ in })
        }
    }

}
