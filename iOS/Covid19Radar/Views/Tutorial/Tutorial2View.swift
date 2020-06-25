//
//  Tutorial2View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Tutorial2View: View {

    @State var isPresented = false

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 16) {
                    Text("TutorialPage2Description1")
                        .defaultTitle()

                    HStack(alignment: .center) {
                        Image("TutorialPage20")
                    }

                    Text("TutorialPage2Description2")
                        .defaultLabel()

                    Text("TutorialPage2Description3")
                        .defaultLabel()

                    Text("TutorialPage2Description4")
                        .defaultLabel()

                    Spacer()

                    LargeActionButton(label: "TutorialPage2Description5") {
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
        .modal(isPresented: $isPresented, destination: Tutorial3View())
    }

}

struct Tutorial2View_Previews: PreviewProvider {
    static var previews: some View {
        Tutorial2View()
    }
}
