//
//  ContentView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()

    // MARK: - Body

    var body: some View {
        ZStack {
            if self.viewModel.isOnboarded {
                SplitView(primary: primaryView(),
                          secondary: secondaryView(),
                          isCollapsed: self.$viewModel.isCollapsed
                )

            } else {
                Tutorial1View()
                    .transition(.move(edge: .bottom))
            }
        }
    }

    // MARK: - Buttons

    var openButton: some View {
        Button(action: {
            withAnimation {
                self.viewModel.isCollapsed = false
            }
        }) {
            Image("IconHamburger")
                .padding(.trailing, 20)
        }
    }

    var closeButton: some View {
        Button(action: {
            withAnimation {
                self.viewModel.isCollapsed = true
            }
        }) {
            Image(systemName: "arrow.left")
                .padding(.trailing, 30)
        }
    }

    var helpButton: some View {
        NavigationLink(destination: HelpMenuView()) {
            Text("MainTutorial")
        }
    }

    // MARK: - Views

    private func primaryView() -> AnyView {
        AnyView(
            NavigationView {
                MenuView()
                    .navigationBarItems(leading: self.closeButton)
                    .environmentObject(viewModel)
            }
        )
    }

    private func secondaryView() -> AnyView {
        switch self.viewModel.selectedIndex {
        case 1:
            return AnyView(NavigationView {
                SettingsView()
                    .navigationBarItems(leading: self.openButton)
            })
        case 2:
            return AnyView(NavigationView {
                InqueryView()
                    .navigationBarItems(leading: self.openButton)
            })
        case 3:
            return AnyView(NavigationView {
                TermsOfServiceView()
                    .navigationBarItems(leading: self.openButton)
            })
        case 4:
            return AnyView(NavigationView {
                PrivacyPolicy2View()
                    .navigationBarItems(leading: self.openButton)
            })
        case 5:
            return AnyView(NavigationView {
                DeveloperView()
                    .navigationBarItems(leading: self.openButton)
            })
        default:
            return AnyView(NavigationView {
                HomeView()
                    .navigationBarItems(leading: self.openButton, trailing: self.helpButton)
            })
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
