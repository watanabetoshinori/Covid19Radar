//
//  HelpMenuView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct HelpMenuView: View {

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                HelpMenuCell(destination: Help1View(), label: "HelpMenuPageLabel1")

                HelpMenuCell(destination: Help2View(), label: "HelpMenuPageLabel2")

                HelpMenuCell(destination: Help3View(), label: "HelpMenuPageLabel3")

                HelpMenuCell(destination: Help4View(), label: "HelpMenuPageLabel4")

            }
            .padding(.vertical)
            .padding(.horizontal, 24)
        }
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("HelpMenuPageTitle", displayMode: .inline)
    }

}

struct HelpMenuCell<Destination>: View where Destination: View {

    var destination: Destination

    var label: String

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(alignment: .center, spacing: 16) {
                Text(LocalizedStringKey(label))
                    .defaultLabel()

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(Color(UIColor.systemGray3))
            }
        }
        .foregroundColor(Color.primary)
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
    }

}

struct HelpMenuView_Previews: PreviewProvider {
    static var previews: some View {
        HelpMenuView()
    }
}
