//
//  SplitView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//
//  This structure was based on the following repositories code:
//  https://github.com/fermoya/CustomNavigations
//

import SwiftUI

struct SplitView<Primary, Secondary>: View where Primary: View, Secondary: View {

    var primary: Primary

    var secondary: Secondary

    @Binding var isCollapsed: Bool

    @State private var draggingOffset: CGFloat = 0

    private let revealRatio: CGFloat = 0.8

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                self.secondary

                self.dimmingView
                    .opacity(self.isCollapsed ? 0.0 : 0.3)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .onTapGesture {
                        if self.isCollapsed {
                            return
                        }

                        withAnimation {
                            self.isCollapsed.toggle()
                        }
                    }

                self.primary
                    .frame(width: self.primarySize(proxy).width)
                    .offset(x: self.primaryOffset(proxy), y: 0)
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        if self.isCollapsed {
                            return
                        }
                        withAnimation {
                            self.draggingOffset = min(0, max(-self.primarySize(proxy).width, value.translation.width))
                        }
                    }).onEnded({ _ in
                        if self.isCollapsed {
                            return
                        }

                        withAnimation {
                            if abs(self.draggingOffset) > self.primarySize(proxy).width / 2 {
                                self.isCollapsed.toggle()
                            }
                            self.draggingOffset = 0
                        }
                    })
            )
        }
    }

    private var dimmingView: some View {
        Rectangle()
            .foregroundColor(.black)
    }

    // MARK: - Primary View Layout

    private func primaryOffset(_ proxy: GeometryProxy) -> CGFloat {
        let hiddenOffset = -proxy.size.width * ((1 - revealRatio) * 0.5 + revealRatio) + draggingOffset
        return self.isCollapsed ? hiddenOffset : hiddenOffset + primarySize(proxy).width
    }

    private func primarySize(_ proxy: GeometryProxy) -> CGSize {
        CGSize(width: revealRatio * proxy.size.width, height: proxy.size.height)
    }

}

struct MasterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView(primary: Text("primary"), secondary: Text("secondary"), isCollapsed: .constant(true))
    }
}
