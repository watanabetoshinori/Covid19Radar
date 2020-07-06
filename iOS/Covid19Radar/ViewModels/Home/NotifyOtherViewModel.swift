//
//  NotifyOtherViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class NotifyOtherViewModel: ObservableObject {

    @Published var isPresented = false

    @Published var diagnosisUID = ""

    var isEnabled: Bool {
        diagnosisUID.count == AppConstants.maxDiagnosisUidCount
    }

    func submit() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.isPresented = true
        }
    }

}
