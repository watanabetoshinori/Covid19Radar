//
//  Tutorial6View.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

/*
 * This View is no longer used in v1.1.1
 */

//import SwiftUI
//
//struct Tutorial5View: View {
//
//    @ObservedObject var viewModel = Tutorial5ViewModel()
//
//    @State var isPresented = false
//
//    // MARK: - Body
//
//    var body: some View {
//        GeometryReader { proxy in
//            ScrollView {
//                VStack(spacing: 16) {
//                    Text("TutorialPage5Description1")
//                        .defaultTitle()
//
//                    HStack(alignment: .center) {
//                        Image("TutorialPage50")
//                    }
//                    .padding(.vertical, 24)
//
//                    Text("TutorialPage5Description2")
//                        .defaultLabel()
//
//                    Spacer()
//
//                    LargeActionButton(label: "TutorialPage5Description3", action: self.viewModel.enable)
//
//                    DefferActionButton(label: "TutorialPage5Description4", action: self.viewModel.disable)
//                }
//                .padding(.vertical)
//                .padding(.horizontal, 24)
//                .frame(minHeight: proxy.size.height)
//            }
//        }
//        .background(Color(UIColor.systemBackground))
//        .navigationBarTitle("", displayMode: .inline)
//        .navigationBarHidden(true)
//        .onReceive(self.viewModel.$isPresented, perform: { (newValue) in
//            withAnimation {
//                self.isPresented = newValue
//            }
//        })
//        .modal(isPresented: $isPresented, destination: Tutorial6View())
//    }
//
//}
//
//struct Tutorial5View_Previews: PreviewProvider {
//    static var previews: some View {
//        Tutorial5View()
//    }
//}
