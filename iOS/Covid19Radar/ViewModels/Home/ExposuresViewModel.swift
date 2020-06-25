//
//  ExposuresViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class ExposuresViewModel: ObservableObject {

    var exposureSummaries = LocalStore.shared.exposureSummaries

}
