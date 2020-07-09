//
//  LicenseView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct LicenseView: View {

    let url = AppSettings.shared.licenseUrl

    @ObservedObject private var webViewModel = WebViewModel()

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            WebView(url: self.url, viewModel: self.webViewModel)
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("TitleLicenseAgreement", displayMode: .inline)
    }

}

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView()
    }
}
