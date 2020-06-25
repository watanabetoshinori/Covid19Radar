//
//  Tutorial1View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Tutorial1View: View {

    @State var isPresented = false

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 32) {
                    Text("TutorialPage1Title2")
                        .defaultTitle()

                    HStack {
                        Image("TutorialPage10")
                        Text("TutorialPage1Description1")
                            .defaultLabel()
                    }

                    HStack {
                        Text("TutorialPage1Description2")
                            .defaultLabel()
                        Image("TutorialPage11")
                    }

                    HStack {
                        Image("TutorialPage12")
                        Text("TutorialPage1Description3")
                            .defaultLabel()
                    }

                    Spacer()

                    LargeActionButton(label: "TutorialPage1Button") {
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
        .modal(isPresented: $isPresented, destination: Tutorial2View())
    }

}

struct Tutorial1View_Previews: PreviewProvider {
    static var previews: some View {
        Tutorial1View()
    }
}
