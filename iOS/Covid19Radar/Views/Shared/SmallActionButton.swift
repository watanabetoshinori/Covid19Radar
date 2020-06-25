//
//  SmallActionButton.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct SmallActionButton: View {

    var label: String

    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(LocalizedStringKey(label))
                .fontWeight(.bold)
                .defaultSubLabel()
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .foregroundColor(Color.black)
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
        .background(Color("ActionButton"))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.accentColor, lineWidth: 4)
        )
    }

}

struct SmallActionButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallActionButton(label: "Label") {
        }
    }
}
