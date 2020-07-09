//
//  Tutorial4ViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class Tutorial4ViewModel: ObservableObject {

    var exposureNotification: ExposureNotification

    @Published var isPresented = false

    init(exposureNotification: ExposureNotification) {
        self.exposureNotification = exposureNotification
    }

    func enable() {
        exposureNotification.isEnabled { enabled in
            if enabled {
                self.isPresented = true
            } else {
                self.exposureNotification.start { _ in
                    self.isPresented = true
                }
            }
        }
    }

    func disable() {
        self.isPresented = true
    }

}
