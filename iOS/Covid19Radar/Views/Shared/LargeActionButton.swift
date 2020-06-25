//
//  TutorialButton.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct LargeActionButton: View {

    var label: String

    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(LocalizedStringKey(label))
                .fontWeight(.bold)
                .defaultLabel()
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .foregroundColor(Color.black)
        .padding()
        .background(Color("ActionButton"))
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.accentColor, lineWidth: 4)
        )
    }

}

struct TutorialButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeActionButton(label: "Label", action: {})
            .padding()
    }
}
