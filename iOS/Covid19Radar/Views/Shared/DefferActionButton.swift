//
//  DefferActionButton.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct DefferActionButton: View {

    var label: String

    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(LocalizedStringKey(label))
                .fontWeight(.bold)
                .defaultLabel()
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .foregroundColor(Color(UIColor.systemGray2))
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color(UIColor.systemGray3), lineWidth: 4)
        )
    }

}

struct DefferActionButton_Previews: PreviewProvider {
    static var previews: some View {
        DefferActionButton(label: "Label", action: {})
            .padding()
    }
}
