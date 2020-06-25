//
//  Help1View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Help1View: View {

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("HelpPage1MainTitle")
                    .defaultTitle()
                    .padding(.top, 20)

                HStack(alignment: .center) {
                    Image("HelpPage20")
                }

                Text("HelpPage1Description1Text")
                    .defaultLabel()

                Text("HelpPage1Description2Title")
                    .defaultTitle()
                    .padding(.top, 20)

                HStack(alignment: .center) {
                    Image("HelpPage22")
                }

                Text("HelpPage1Description2Text")
                    .defaultLabel()

                Text("HelpPage1Description3Title")
                    .defaultTitle()
                    .padding(.top, 20)

                HStack(alignment: .center) {
                    Image("HelpPage21")
                }

                Text("HelpPage1Description3Text")
                    .defaultLabel()
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("HelpPage1Title", displayMode: .inline)
    }

}

struct Help1View_Previews: PreviewProvider {
    static var previews: some View {
        Help1View()
    }
}
