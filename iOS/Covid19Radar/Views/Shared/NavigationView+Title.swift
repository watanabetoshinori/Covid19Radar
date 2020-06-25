//
//  NavigationView+Title.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright (c) Vatsal Manot
//
//  This structure was based on the following repositories code:
//  https://github.com/SwiftUIX/SwiftUIX
//

import SwiftUI
import UIKit

@usableFromInline
struct NavigationBarConfigurator<Center: View>: UIViewControllerRepresentable {

    @usableFromInline
    class UIViewControllerType: UIViewController {
        var center: Center? {
            didSet {
                updateNavigationBar(parent: parent)
            }
        }

        override func willMove(toParent parent: UIViewController?) {
            updateNavigationBar(parent: parent)
            super.willMove(toParent: parent)
        }

        private func updateNavigationBar(parent: UIViewController?) {
            guard let parent = parent else {
                return
            }

            if let center = center {
                if !(center is EmptyView) {
                    parent.navigationItem.titleView = UIHostingController(rootView: center).view
                }
            } else {
                parent.navigationItem.titleView = nil
            }

            parent.navigationItem.titleView?.sizeToFit()
        }
    }

    let center: Center

    @usableFromInline
    init(center: Center) {
        self.center = center
    }

    @usableFromInline
    func makeUIViewController(context: Context) -> UIViewControllerType {
        .init()
    }

    @usableFromInline
    func updateUIViewController(_ viewController: UIViewControllerType, context: Context) {
        viewController.center = center
    }

}

extension View {

    @inlinable
    public func navigationBarTitleView<V: View>(_ center: V) -> some View {
        background(NavigationBarConfigurator(center: center))
    }

}
