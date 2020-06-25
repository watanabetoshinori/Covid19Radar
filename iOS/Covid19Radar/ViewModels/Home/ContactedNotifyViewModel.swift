//
//  ContactedNotifyViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class ContactedNotifyViewModel: ObservableObject {

    var exposureSummaryCount = LocalStore.shared.exposureSummaries.count

}
