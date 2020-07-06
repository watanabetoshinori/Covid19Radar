//
//  PrivacyPolicyViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class PrivacyPolicyViewModel: ObservableObject {

    @Published var isPresented = false

    func agree() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.isPresented = true
        }
    }

}
