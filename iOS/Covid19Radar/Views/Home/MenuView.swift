//
//  MenuView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct MenuView: View {

    // MARK: - Body

    var body: some View {
        ScrollView {
            Divider()

            self.homeRow

            self.settingsRow

            self.inqueryRow

            self.privacyPolicyRow

            #if DEBUG
            self.developerRow
            #endif
        }
        .navigationBarTitle("メニュー", displayMode: .inline)
    }

    // MARK: - Rows

    var homeRow: some View {
        Group {
            MenuViewCell(symbol: "house.fill", text: "HomePageTitle", index: 0)
            Divider()
        }
    }

    var settingsRow: some View {
        Group {
            MenuViewCell(symbol: "gear", text: "SettingsPageTitle", index: 1)
            Divider()
        }
    }

    var inqueryRow: some View {
        Group {
            MenuViewCell(symbol: "envelope.fill", text: "InqueryPageTitle", index: 2)
            Divider()
        }
    }

    var privacyPolicyRow: some View {
        Group {
            MenuViewCell(symbol: "doc.plaintext", text: "TermsofservicePageTitle", index: 3)
            Divider()
            MenuViewCell(symbol: "shield.lefthalf.fill", text: "PrivacyPolicyPageTitle", index: 4)
            Divider()
        }
    }

    var developerRow: some View {
        Group {
            MenuViewCell(symbol: "hammer.fill", text: "Developer", index: 5)
            Divider()
        }
    }

}

struct MenuViewCell: View {

    @EnvironmentObject var contentViewModel: ContentViewModel

    var symbol: String

    var text: String

    var index: Int

    var body: some View {
        Button(action: {
            withAnimation {
                self.contentViewModel.selectedIndex = self.index
                self.contentViewModel.isCollapsed = true
            }
        }) {
            HStack {
                Image(systemName: symbol)

                Text(LocalizedStringKey(text))
                    .foregroundColor(.primary)
                    .defaultLabel()

                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
    }

}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
