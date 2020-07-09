//
//  UserDialogs.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class LoadingDialog: NSObject {

    var showLoadingPublisher = NotificationCenter.default.publisher(for: .init(rawValue: "ShowLoading"))

    var hideLoadingPublisher = NotificationCenter.default.publisher(for: .init(rawValue: "HideLoading"))

    // MARK: - Initializing a Singleton

    static let shared = LoadingDialog()

    override private init() {

    }

    func show() {
        NotificationCenter.default.post(name: .init("ShowLoading"), object: nil)

    }

    func hide() {
        NotificationCenter.default.post(name: .init("HideLoading"), object: nil)
    }

}
