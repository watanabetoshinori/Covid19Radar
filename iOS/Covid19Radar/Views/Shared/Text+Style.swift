//
//  Text+Style.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

extension Text {

    func defaultTitle() -> some View {
        self
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }

    func defaultLabel() -> some View {
        self
            .font(.body)
            .fixedSize(horizontal: false, vertical: true)
    }

    func defaultSubTitle() -> some View {
        self
            .font(.headline)
            .fontWeight(.bold)
            .fixedSize(horizontal: false, vertical: true)
    }

    func defaultSubLabel() -> some View {
        self
            .font(.subheadline)
            .fixedSize(horizontal: false, vertical: true)
    }

}
