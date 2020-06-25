//
//  TermsOfServiceView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct TermsOfServiceView: View {

    let url = NSLocalizedString("UrlTermOfUse", comment: "")

    @ObservedObject private var webViewModel = WebViewModel()

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            WebView(url: url, viewModel: self.webViewModel)
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("TermsofservicePageTitle", displayMode: .inline)
    }

}

struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
