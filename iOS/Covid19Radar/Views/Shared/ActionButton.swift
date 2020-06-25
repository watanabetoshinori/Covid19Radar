//
//  ActionButton.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ActionButton: View {

    var label: String

    var symbol: String?

    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(LocalizedStringKey(label))
                .fontWeight(.bold)
                .defaultLabel()
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.horizontal, symbol != nil ? 30 : 0)
        }
        .padding()
        .foregroundColor(Color.black)
        .background(Color("ActionButton"))
        .cornerRadius(30)
        .overlay(
            HStack {
                if symbol != nil {
                    Image(systemName: symbol!)
                        .frame(width: 30)
                        .foregroundColor(.accentColor)
                }
                Spacer()
            }
            .padding(.horizontal, 8)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.accentColor, lineWidth: 4)
        )
    }

}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(label: "Label", symbol: "circle.fill", action: {})
            .padding()
    }
}
