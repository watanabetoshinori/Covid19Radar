//
//  Tutorial3View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Tutorial3View: View {

    let url = NSLocalizedString("UrlTermOfUse", comment: "")

    @ObservedObject private var webViewModel = WebViewModel()

    @ObservedObject var viewModel = Tutorial3ViewModel()

    @State var isPresented = false

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 16) {
                Text("TutorialPage3Title")
                    .defaultTitle()

                VStack {
                    ProgressView(progress: Float(self.webViewModel.webView.estimatedProgress))
                        .opacity(Float(self.webViewModel.webView.estimatedProgress) == 1 ? 0 : 1)

                    WebView(url: self.url, viewModel: self.webViewModel)
                }

                Spacer()

                LargeActionButton(label: "TutorialPage3ButtonText", action: self.viewModel.agree)
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
            .frame(minHeight: proxy.size.height)
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onReceive(self.viewModel.$isPresented, perform: { (newValue) in
            withAnimation {
                self.isPresented = newValue
            }
        })
        .modal(isPresented: self.$isPresented, destination: Tutorial4View())
    }

}

struct Tutorial3View_Previews: PreviewProvider {
    static var previews: some View {
        Tutorial3View()
    }
}
