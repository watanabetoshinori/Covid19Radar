//
//  Help2View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Help2View: View {

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("HelpPage2Label1")
                    .defaultTitle()
                    .padding(.top, 20)

                HStack {
                    Image("HelpPage30")
                    Text("HelpPage2Description1")
                        .defaultLabel()
                }

                Text("HelpPage2Label2")
                    .defaultTitle()

                Text("HelpPage2Description2")
                    .defaultLabel()

                HStack(alignment: .center) {
                    Image("HelpPage31")
                }

                Text("HelpPage2Label3")
                    .defaultTitle()
                    .padding(.top, 20)

                Text("HelpPage2Description3")
                    .defaultLabel()

                HStack(alignment: .center) {
                    Image("HelpPage32")
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("HelpPage2Title", displayMode: .inline)
    }

}

struct Help2View_Previews: PreviewProvider {
    static var previews: some View {
        Help2View()
    }
}
