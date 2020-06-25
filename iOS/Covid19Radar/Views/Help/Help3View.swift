//
//  Help3View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Help3View: View {

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                HStack {
                    Image("HelpPage40")
                    Text("HelpPage3Description1")
                        .defaultLabel()
                }

                HStack {
                    Text("HelpPage3Description2")
                        .defaultLabel()
                    Image("HelpPage41")
                }

                HStack {
                    Image("HelpPage42")
                    Text("HelpPage3Description3")
                        .defaultLabel()
                }

                HStack {
                    Text("HelpPage3Description4")
                        .defaultLabel()
                    Image("HelpPage44")
                }

                HStack {
                    Image("HelpPage45")
                    Text("HelpPage3Description5")
                        .defaultLabel()
                }

            }
            .padding()
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("HelpPage3Title", displayMode: .inline)
    }
}

struct Help3View_Previews: PreviewProvider {
    static var previews: some View {
        Help3View()
    }
}
