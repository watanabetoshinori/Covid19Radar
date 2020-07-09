//
//  ActivityView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let uiViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return uiViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {

    }

}
