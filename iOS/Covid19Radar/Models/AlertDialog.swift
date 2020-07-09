//
//  Alert.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct AlertDialog: Identifiable {

    let id = UUID().uuidString

    var title: String

    var message: String

    var okText: String

    var cancelText: String?

    var action: ((Bool) -> Void)?

}
