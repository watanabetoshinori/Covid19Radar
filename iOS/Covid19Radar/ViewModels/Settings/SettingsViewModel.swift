//
//  SettingsViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class SettingsViewModel: ObservableObject {

    var exposureNotification: ExposureNotification

    @Published var isPresented = false

    @Published var alertDialog: AlertDialog?

    init(exposureNotification: ExposureNotification) {
        self.exposureNotification = exposureNotification
    }

    func reset() {
        alertDialog = AlertDialog(title: "SettingsPageDialogResetTitle",
                                  message: "SettingsPageDialogResetText",
                                  okText: "ButtonOk",
                                  cancelText: "ButtonCancel") { result in
            if result {
                self.exposureNotification.isEnabled { enabled in
                    if enabled {
                        self.exposureNotification.stop { _ in
                            self.resetAllDataAndClose()
                        }
                    } else {
                        self.resetAllDataAndClose()
                    }
                }
            }
        }
    }

    private func resetAllDataAndClose() {
        // Reset all data
        UserData.shared.reset()
        self.alertDialog = AlertDialog(title: "",
                                       message: "SettingsPageDialogResetCompletedText",
                                       okText: "ButtonOk") { _ in
            // Application close
            exit(0)
        }
    }

}
