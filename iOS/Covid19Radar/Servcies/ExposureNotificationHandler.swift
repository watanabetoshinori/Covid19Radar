//
//  ExposureNotificationHandler.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/07/08.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import ExposureNotification

protocol ExposureNotificationHandler {

    var userExplanation: String { get }

    func registerUser(completionHandler: @escaping (Result<RegisterResult, Error>) -> Void)

    func getConfiguration(completionHandler: @escaping (Configuration) -> Void)

    func fetchExposureKeyBatchFilesFromServer(submitBatches: @escaping ([String], @escaping () -> Void) -> Void, completionHandler: @escaping () -> Void)

    func exposureDetected(summary: ENExposureDetectionSummary, getExposureInfo: @escaping (@escaping ([ENExposureInfo]) -> Void) -> Void, completionHandler: @escaping  () -> Void)

    func uploadSelfExposureKeysToServer(temporaryExposureKeys: [ENTemporaryExposureKey], completionHandler: @escaping  (Error?) -> Void)

}
