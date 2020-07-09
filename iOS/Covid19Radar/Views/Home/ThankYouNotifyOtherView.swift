//
//  ThankYouNotifyOtherView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ThankYouNotifyOtherView: View {

    @Binding var isParentPresented: Bool

    @State var isPresentedActionSheet = false

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 16) {
                    HStack(alignment: .center) {
                        Image("TutorialPage60")
                    }

                    Text("AppName")
                        .defaultTitle()
                        .padding(.vertical)

                    Text("ThankYouNotifyOtherPageLabel1")
                        .defaultTitle()
                        .padding(.vertical)

                    Text("ThankYouNotifyOtherPageDescription1")
                        .defaultLabel()
                        .padding()
                        .background(Color("ContanctedNotify"))
                        .cornerRadius(8)

                    Spacer()

                    LargeActionButton(label: "NotContactPageButtonText") {
                        self.isPresentedActionSheet = true
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 24)
                .frame(minHeight: proxy.size.height)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: homeButton)
        .sheet(isPresented: self.$isPresentedActionSheet) {
            ActivityView(activityItems: [URL(string: AppSettings.shared.appStoreUrl)])
        }
    }

    // MARK: - Button

    var homeButton: some View {
        Button("HomePageTitle") {
            self.isParentPresented = false
        }
    }

}

struct ThankYouNotifyOtherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ThankYouNotifyOtherView(isParentPresented: .constant(true))
        }
    }
}
