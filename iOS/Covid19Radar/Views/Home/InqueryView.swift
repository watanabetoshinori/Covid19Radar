//
//  InqueryView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct InqueryView: View {

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    self.mailRow
                    self.urlRow
                    self.url2Row
                }
                .padding(.top, 8)
                .frame(width: proxy.size.width)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("InqueryPageTitle", displayMode: .inline)
    }

    // MARK: - Rows

    var mailRow: some View {
        Group {
            VStack(alignment: .leading, spacing: 8) {
                Button("appsupport@cov19.mhlw.go.jp") {
                    self.openURL("mailto:appsupport@cov19.mhlw.go.jp"
                        + "?subject=" + NSLocalizedString("InqueryMailSubject", comment: "").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                        + "&body=" + NSLocalizedString("InqueryMailBody", comment: "").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
                }
                .foregroundColor(.accentColor)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)

                Text("InqueryPageDescription1")
                    .defaultLabel()
            }
            .padding(.horizontal)
            .padding(.vertical, 4)

            Divider()
        }
    }

    var urlRow: some View {
        Group {
            VStack(alignment: .leading, spacing: 8) {
                Text("InqueryPageDescription3")
                    .defaultLabel()

                Button("https://www.mhlw.go.jp/stf/seisakunitsuite/bunya/cocoa_00138.html") {
                    self.openURL("https://www.mhlw.go.jp/stf/seisakunitsuite/bunya/cocoa_00138.html")
                }
                .foregroundColor(.accentColor)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)

            Divider()
        }
    }

    var url2Row: some View {
        Group {
            VStack(alignment: .leading, spacing: 8) {
                Text("InqueryPageDescription4")
                    .defaultLabel()

                Button("https://www.mhlw.go.jp/stf/seisakunitsuite/bunya/kenkou_iryou/covid19_qa_kanrenkigyou_00009.html") {
                    self.openURL("https://www.mhlw.go.jp/stf/seisakunitsuite/bunya/kenkou_iryou/covid19_qa_kanrenkigyou_00009.html")
                }
                .foregroundColor(.accentColor)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)

            Divider()
        }
    }

}

struct InqueryView_Previews: PreviewProvider {
    static var previews: some View {
        InqueryView()
    }
}
