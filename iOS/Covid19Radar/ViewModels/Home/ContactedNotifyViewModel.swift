//
//  ContactedNotifyViewModel.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation
import UIKit

class ContactedNotifyViewModel: ObservableObject {

    var exposureCount = UserData.shared.exposureInformation.count

    func contactByPhone() {
        guard let url = URL(string: NSLocalizedString("UrlContactedPhone", comment: "")) else {
            return
        }

        LoadingDialog.shared.show()

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in

            LoadingDialog.shared.hide()

            guard let data = data,
                let contact = try? JSONDecoder().decode(Contact.self, from: data),
                let phoneCallURL = URL(string: "tel:\(contact.phone)") else {
                return
            }

            DispatchQueue.main.async {
                UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }

        task.resume()
    }

}
