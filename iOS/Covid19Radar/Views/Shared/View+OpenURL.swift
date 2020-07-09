//
//  View+OpenURL.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

extension View {

    func openURL(_ urlString: String) {
        guard let url = URL(string: NSLocalizedString(urlString, comment: "")) else {
            return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}
