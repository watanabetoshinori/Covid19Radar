//
//  ExposuresView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct ExposuresView: View {

    @ObservedObject var viewModel = ExposuresViewModel()

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        Text("ExposuresPageLabel1")
                            .defaultLabel()
                            .padding(.horizontal)
                            .padding(.vertical, 4)

                        Divider()
                    }

                    ForEach(self.viewModel.exposureSummaries, id: \.id) { exposure in
                        ExposureRow(date: exposure.dateString, count: exposure.count)
                    }
                }
                .padding(.top, 8)
                .frame(width: proxy.size.width)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("ExposuresPageTitle", displayMode: .inline)
    }

}

struct ExposureRow: View {

    var date: String

    var count: Int

    var body: some View {
        Group {
            NavigationLink(destination: LicenseView()) {
                Text(date)
                    .defaultLabel()

                Spacer()

                (Text("\(count)")
                    + Text("件"))
                    .defaultLabel()
            }
            .foregroundColor(.primary)
            .padding(.horizontal)
            .padding(.vertical, 4)

            Divider()
        }
    }

}

struct ExposuresView_Previews: PreviewProvider {
    static var previews: some View {
        ExposuresView()
    }
}
