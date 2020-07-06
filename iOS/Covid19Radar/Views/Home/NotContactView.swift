//
//  NotContactView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct NotContactView: View {

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 32) {
                    Text("NotContactPageLabel1")
                        .defaultTitle()

                    Text("NotContactPageDescription1")
                        .defaultLabel()

                    HStack(alignment: .center) {
                        Image("Nocontact10")
                    }

                    Spacer()

                    LargeActionButton(label: "NotContactPageButtonText") {
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 24)
                .frame(minHeight: proxy.size.height)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("NotContactPageTitle", displayMode: .inline)
    }

}

struct NotContactView_Previews: PreviewProvider {
    static var previews: some View {
        NotContactView()
    }
}
