//
//  Tutorial4ViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class Tutorial4ViewModel: ObservableObject {

    @Published var isPresented = false

    func enable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.isPresented = true
        }
    }

    func disable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.isPresented = true
        }
    }

}
