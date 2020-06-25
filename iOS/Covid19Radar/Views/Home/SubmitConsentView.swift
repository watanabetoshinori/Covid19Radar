//
//  SubmitConsentView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct SubmitConsentView: View {

    @Binding var isParentPresented: Bool

    @State var isPresented = false

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 16) {
                    HStack(alignment: .center) {
                        Image("TutorialPage20")
                    }
                    .padding(.vertical)

                    Text("SubmitConsentPageDescription1")
                        .defaultLabel()

                    Text("SubmitConsentPageDescription2")
                        .defaultLabel()

                    Text("SubmitConsentPageDescription3")
                        .defaultLabel()

                    Text("SubmitConsentPageDescription4")
                        .defaultLabel()

                    Text("SubmitConsentPageDescription5")
                        .defaultLabel()

                    Spacer()

                    LargeActionButton(label: "SubmitConsentPageDescription6") {
                        self.isPresented = true
                    }
                    .padding(.top, 16)

                    NavigationLink(destination: NotifyOtherView(isParentPresented: self.$isParentPresented),
                                   isActive: self.$isPresented) {
                        Rectangle()
                    }
                    .isDetailLink(false)
                    .frame(height: 0)
                }
                .padding(.vertical)
                .padding(.horizontal, 24)
                .frame(minHeight: proxy.size.height)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("SubmitConsentPageTitle1", displayMode: .inline)
    }

}

struct SubmitConsentView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitConsentView(isParentPresented: .constant(true))
    }
}
