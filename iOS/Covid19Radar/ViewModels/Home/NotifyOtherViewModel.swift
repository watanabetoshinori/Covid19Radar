//
//  NotifyOtherViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class NotifyOtherViewModel: ObservableObject {

    var exposureNotification: ExposureNotification

    @Published var isPresented = false

    @Published var diagnosisUID = ""

    @Published var alertDialog: AlertDialog?

    var errorCount = 0

    var isEnabled: Bool {
        diagnosisUID.count == AppConstants.maxDiagnosisUidCount
    }

    init(exposureNotification: ExposureNotification) {
        self.exposureNotification = exposureNotification
    }

    func submit() {
        alertDialog = AlertDialog(title: "NotifyOtherPageDiag1Title",
                                  message: "NotifyOtherPageDiag1Message",
                                  okText: "ButtonAgree",
                                  cancelText: "ButtonCancel")
        { result in
            if result == false {
                DispatchQueue.main.async {
                    self.alertDialog = AlertDialog(title: "",
                                                  message: "NotifyOtherPageDiag2Message",
                                                  okText: "ButtonOk")
                }
                return
            }

            if self.errorCount >= AppConstants.maxErrorCount {
                DispatchQueue.main.async {
                    self.alertDialog = AlertDialog(title: "NotifyOtherPageDiagErrorTitle",
                                                   message: "NotifyOtherPageDiagAppClose",
                                                   okText: "ButtonOk")
                    { _ in
                        exit(0)
                    }
                }
                return
            }

            if self.diagnosisUID.isEmpty {
                self.errorCount += 1
                DispatchQueue.main.async {
                    self.alertDialog = AlertDialog(title: "NotifyOtherPageDiagErrorTitle",
                                                   message: "NotifyOtherPageDiag4Message",
                                                   okText: "ButtonOk")
                }
                return
            }

            if self.diagnosisUID.range(of: AppConstants.positiveRegex, options: .regularExpression) == nil {
                self.errorCount += 1
                DispatchQueue.main.async {
                    self.alertDialog = AlertDialog(title: "NotifyOtherPageDiagErrorTitle",
                                                   message: "NotifyOtherPageDiag5Message",
                                                   okText: "ButtonOk")
                }
                return
            }

            LoadingDialog.shared.show()

            self.exposureNotification.isEnabled { enabled in
                if enabled == false {
                    self.alertDialog = AlertDialog(title: "NotifyOtherPageDiag6Title",
                                                   message: "NotifyOtherPageDiag6Message",
                                                   okText: "ButtonOk")
                    return
                }

                let diagnosis = PositiveDiagnosisState(diagnosisUid: self.diagnosisUID,
                                                       diagnosisDate: Date(),
                                                       shared: false)
                UserData.shared.add(diagnoses: diagnosis)

                LoadingDialog.shared.show()

                self.exposureNotification.submitSelfDiagnosis { error in

                    LoadingDialog.shared.hide()

                    if let error = error {
                        print(error)

                        self.errorCount += 1
                        self.alertDialog = AlertDialog(title: "ButtonFailed",
                                                       message: "NotifyOtherPageDialogExceptionText",
                                                       okText: "ButtonOk")
                        return
                    }

                    self.alertDialog = AlertDialog(title: "ButtonComplete",
                                                   message: "NotifyOtherPageDialogSubmittedText",
                                                   okText: "ButtonOk")
                    { _ in
                        self.isPresented = true
                    }
                }
            }
        }
    }

}
