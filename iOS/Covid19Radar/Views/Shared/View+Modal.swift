//
//  View+Modal.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

extension View {

    func modal<Destination: View>(isPresented: Binding<Bool>,
                                  destination: Destination) -> some View {
        modifier(ModaViewModifier(isPresented: isPresented,
                                  destination: destination))
    }

}

private struct ModaViewModifier<Destination>: ViewModifier where Destination: View {

    @Binding var isPresented: Bool

    var destination: Destination

    func body(content: Self.Content) -> some View {
        ZStack {
            if self.isPresented {
                self.destination
                    .transition(.move(edge: .bottom))
            } else {
                content
            }
        }
    }

}
