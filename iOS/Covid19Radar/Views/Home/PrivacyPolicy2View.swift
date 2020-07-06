//
//  PrivacyPolicyView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct PrivacyPolicy2View: View {

    let url = NSLocalizedString("UrlPrivacyPolicy", comment: "")

    @ObservedObject private var webViewModel = WebViewModel()

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            WebView(url: self.url, viewModel: self.webViewModel)
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("PrivacyPolicyPageTitle", displayMode: .inline)
    }

}

struct PrivacyPolicyView2_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy2View()
    }
}
