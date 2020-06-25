//
//  HomeView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel = HomeViewModel()

    @State var isPresented = false

    @State private var selectedIndex = 0

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                exposuresCard

                submitCard

                shareCard

                NavigationLink(destination: destinationView(),
                               isActive: self.$isPresented) {
                    Rectangle()
                }
                .isDetailLink(false)
                .frame(height: 0)
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
        }
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarTitleView(Image("HeaderLogo"))
    }

    // MARK: - Cards

    var exposuresCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            (Text(viewModel.startDate)
                + Text("HomePageDescription0")
                + Text(" ")
                + Text(viewModel.pastDate)
                + Text(" ")
                + Text("HomePagePastDays")
                + Text(" ")
                + Text("HomePageDescription1"))
                .font(.headline)
                .fontWeight(.regular)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 4)

            ActionButton(label: "HomePageDescription2") {
                self.selectedIndex = 0
                self.isPresented = true
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
    }

    var submitCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("HomePageDescription3")
                .defaultSubTitle()

            HStack(alignment: .top, spacing: 16) {
                Image("HOMEPage10")
                Text("HomePageHeader2Description")
                    .defaultSubLabel()
            }

            ActionButton(label: "HomePageDescription4") {
                self.selectedIndex = 1
                self.isPresented = true
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
    }

    var shareCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("HomePageHeader3Title")
                .defaultSubTitle()

            HStack(alignment: .top, spacing: 16) {
                Image("HOMEPage11")
                Text("HomePageHeader3Description")
                    .defaultSubLabel()
            }

            ActionButton(label: "HomePageDescription5") {
                withAnimation {
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
    }

    // MARK: - Destination View

    private func destinationView() -> AnyView {
        switch self.selectedIndex {
        case 1:
            return AnyView(
                SubmitConsentView(isParentPresented: self.$isPresented)
            )
        default:
            if viewModel.exposureSummaryCount == 0 {
                return AnyView(
                    NotContactView()
                )
            } else {
                return AnyView(
                    ContactedNotifyView()
                )
            }
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
