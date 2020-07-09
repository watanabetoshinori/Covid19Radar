//
//  Tutorial3ViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class Tutorial3ViewModel: ObservableObject {

    var handler: ExposureNotificationHandler

    @Published var isPresented = false

    @Published var alertDialog: AlertDialog?

    init(handler: ExposureNotificationHandler) {
        self.handler = handler
    }

    func agree() {
        // User is already registered.
        if UserData.shared.userUuid.isEmpty == false,
            UserData.shared.secret.isEmpty == false {
            self.isPresented = true
            return
        }

        LoadingDialog.shared.show()

        handler.registerUser { [weak self] result in

            LoadingDialog.shared.hide()

            switch result {
            case let .success(result):
                UserData.shared.userUuid = result.userUuid
                UserData.shared.secret = result.secret
                UserData.shared.jumpConsistentSeed = result.jumpConsistentSeed
                UserData.shared.startDateTime = Date()
                self?.isPresented = true

            case let .failure(error):
                print(error)
                self?.alertDialog = AlertDialog(title: "DialogNetworkConnectionError",
                                                message: "DialogNetworkConnectionErrorTitle",
                                                okText: "ButtonOk")
            }
        }
    }

}
