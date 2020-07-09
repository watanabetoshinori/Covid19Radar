//
//  DeveloperView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct DeveloperView: View {

    @ObservedObject var viewModel = DeveloperViewModel()

    // MARK: - Body

    var body: some View {
        List {
            Button(action: self.viewModel.simulateExposure) { Text("Simulate Exposure") }
            Button(action: self.viewModel.resetOnboarding) { Text("Reset Onboarding") }
            Button(action: self.viewModel.resetLocalExposures) { Text("Reset Exposure") }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("Developer", displayMode: .inline)
    }

}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}
