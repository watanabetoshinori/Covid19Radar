//
//  ProgressView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ProgressView: UIViewRepresentable {

    var progress: Float = 0

    func makeUIView(context: Context) -> UIProgressView {
        let uiView = UIProgressView()
        return uiView
    }

    func updateUIView(_ uiView: UIProgressView, context: Context) {
        uiView.progress = progress
    }

}
