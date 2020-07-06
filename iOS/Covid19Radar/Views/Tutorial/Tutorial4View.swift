//
//  Tutorial5View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Tutorial4View: View {

    @ObservedObject var viewModel = Tutorial4ViewModel()

    @State var isPresented = false

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 16) {
                    Text("TutorialPage4Title2")
                        .defaultTitle()

                    HStack(alignment: .center) {
                        Image("TutorialPage40")
                    }
                    .padding(.vertical, 24)

                    Text("TutorialPage4Description")
                        .defaultLabel()

                    Spacer()

                    LargeActionButton(label: "TutorialPage4Button1", action: self.viewModel.enable)

                    DefferActionButton(label: "TutorialPage4Button2", action: self.viewModel.disable)
                }
                .padding(.vertical)
                .padding(.horizontal, 24)
                .frame(minHeight: proxy.size.height)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onReceive(self.viewModel.$isPresented, perform: { (newValue) in
            withAnimation {
                self.isPresented = newValue
            }
        })
        .modal(isPresented: $isPresented, destination: Tutorial6View())
    }

}

struct Tutorial4View_Previews: PreviewProvider {
    static var previews: some View {
        Tutorial4View()
    }
}
