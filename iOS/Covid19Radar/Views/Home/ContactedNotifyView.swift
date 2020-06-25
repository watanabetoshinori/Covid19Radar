//
//  ContactedNotifyView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ContactedNotifyView: View {

    @ObservedObject var viewModel = ContactedNotifyViewModel()

    @State var isPresented = false

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(spacing: 16) {
                        HStack(alignment: .top, spacing: 8) {
                            Image("InfoMark")

                            (Text("ContactedNotifyPageMainText")
                                + Text("\n\(self.viewModel.exposureSummaryCount)")
                                + Text("ContactedNotifyPageCountText"))
                                .defaultTitle()
                        }
                        .padding(.vertical)

                        Text("ContactedNotifyPageDescription1")
                            .defaultLabel()

                        ActionButton(label: "ContactedNotifyPageButton2", symbol: "square.and.pencil") {

                        }

                        ActionButton(label: "ContactedNotifyPageButton3", symbol: "phone.fill") {

                        }

                        Text("ContactedNotifyPageDescription2")
                            .defaultLabel()
                    }
                    .padding()
                    .background(Color("ContanctedNotify"))
                    .cornerRadius(8)

                    Spacer()

                    LargeActionButton(label: "ContactedNotifyPageButton1") {
                        withAnimation {
                            self.isPresented = true
                        }
                    }

                    NavigationLink(destination: ExposuresView(),
                                   isActive: self.$isPresented) {
                        Rectangle()
                    }
                    .frame(height: 0)
                }
                .padding()
                .frame(minHeight: proxy.size.height)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("ContactedNotifyPageTitle", displayMode: .inline)
    }

}

struct ContactedNotifyView_Previews: PreviewProvider {
    static var previews: some View {
        ContactedNotifyView()
    }
}
