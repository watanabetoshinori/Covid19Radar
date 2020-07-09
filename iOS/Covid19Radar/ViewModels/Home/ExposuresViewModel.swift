//
//  ExposuresViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class ExposuresViewModel: ObservableObject {

    var exposureSummaries = [ExposureSummary]()

    init() {
        let formatter = DateFormatter()
        formatter.dateStyle = .full

        exposureSummaries = Dictionary(grouping: UserData.shared.exposureInformation, by: { $0.timeStamp })
            .map { item in
                ExposureSummary(exposureDate: formatter.string(from: item.key), exposureCount: String(item.value.count))
            }
    }

}
