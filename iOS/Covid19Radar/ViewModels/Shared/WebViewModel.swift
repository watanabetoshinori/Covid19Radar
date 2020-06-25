//
//  WebViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Combine
import WebKit

class WebViewModel: ObservableObject {

    @Published var webView = WKWebView()

    @Published var error: Error?

    private var observers = [NSKeyValueObservation]()

    public init() {
        observers.append(webView.observe(\.estimatedProgress, options: .prior) { (_, _) in
            self.objectWillChange.send()
        })
    }

}
