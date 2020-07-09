//
//  View+Alert.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

extension View {

    func alert(_ dialog: AlertDialog) -> Alert {
        if let cancelText = dialog.cancelText {
            return Alert(title: Text(LocalizedStringKey(dialog.title)),
                  message: Text(LocalizedStringKey(dialog.message)),
                  primaryButton: .cancel(Text(LocalizedStringKey(cancelText)), action: {
                    dialog.action?(false)
                  }),
                  secondaryButton: .default(Text(LocalizedStringKey(dialog.okText)), action: {
                    dialog.action?(true)
                  }))
        } else {
            if dialog.action == nil {
                return Alert(title: Text(LocalizedStringKey(dialog.title)),
                      message: Text(LocalizedStringKey(dialog.message)),
                      dismissButton: .default(Text(LocalizedStringKey(dialog.okText))))
            } else {
                return Alert(title: Text(LocalizedStringKey(dialog.title)),
                      message: Text(LocalizedStringKey(dialog.message)),
                      dismissButton: .default(Text(LocalizedStringKey(dialog.okText)), action: {
                        dialog.action?(true)
                      }))
            }
        }
    }

}
