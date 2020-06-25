//
//  Help4View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Help4View: View {

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                HStack(alignment: .center) {
                    Image("HelpPage50")
                }
                .padding(.top, 10)

                Text("HelpPage4Description")
                    .defaultLabel()
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("HelpPage4Title", displayMode: .inline)
    }

}

struct Help4View_Previews: PreviewProvider {
    static var previews: some View {
        Help4View()
    }
}
