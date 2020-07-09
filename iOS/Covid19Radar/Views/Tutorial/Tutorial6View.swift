//
//  Tutorial7View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Tutorial6View: View {

    @State var isPresented = false

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

                    Text("TutorialPage6Label1")
                        .defaultTitle()
                        .padding(.vertical)

                    Spacer()

                    LargeActionButton(label: "TutorialPage6ButtonText1") {
                        withAnimation {
                            UserData.shared.isOnboarded = true
                        }
                    }

                    LargeActionButton(label: "TutorialPage6ButtonText2") {
                        withAnimation {
                            self.isPresented = true
                        }
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 24)
                .frame(minHeight: proxy.size.height)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .modal(isPresented: $isPresented, destination: self.helpView)
    }

    // MARK: - Help View

    private var helpView: some View {
        NavigationView {
            HelpMenuView()
                .navigationBarItems(leading:
                    Button(action: {
                        withAnimation {
                            self.isPresented = false
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .padding(.trailing, 30)
                    })
        }
    }

}

struct Tutorial6View_Previews: PreviewProvider {
    static var previews: some View {
        Tutorial6View()
    }
}
