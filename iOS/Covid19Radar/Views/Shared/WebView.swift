//
//  WebView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url: String

    @ObservedObject var viewModel: WebViewModel

    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let uiView = viewModel.webView
        uiView.navigationDelegate = context.coordinator
        uiView.load(URLRequest(url: URL(string: url)!))
        return uiView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

    }

    // MARK: - Coordinator Classs

    class Coordinator: NSObject {

        private var view: WebView

        init(_ view: WebView) {
            self.view = view
        }

    }

}

// MARK: - WebView Navigation delegate

extension WebView.Coordinator: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if (error as NSError).code == NSURLErrorCancelled {
            return
        }

        view.viewModel.error = error
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if (error as NSError).code == NSURLErrorCancelled {
            return
        }

        view.viewModel.error = error
    }

}
