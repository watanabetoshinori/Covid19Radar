//
//  Tutorial4View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct PrivacyPolicyView: View {

    let url = NSLocalizedString("UrlPrivacyPolicy", comment: "")

    @ObservedObject private var webViewModel = WebViewModel()

    @State var isPresented = false

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 16) {
                Text("PrivacyPolicyPageTitle")
                    .defaultTitle()

                VStack {
                    ProgressView(progress: Float(self.webViewModel.webView.estimatedProgress))
                        .opacity(Float(self.webViewModel.webView.estimatedProgress) == 1 ? 0 : 1)

                    WebView(url: self.url, viewModel: self.webViewModel)
                }

                Spacer()

                LargeActionButton(label: "ButtonAgree") {
                    withAnimation {
                        self.isPresented = true
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
            .frame(minHeight: proxy.size.height)
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .modal(isPresented: $isPresented, destination: Tutorial4View())
    }

}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
