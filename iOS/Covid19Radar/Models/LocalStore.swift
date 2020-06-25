//
//  LocalStore.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

struct ExposureSummary: Codable {
    let id = UUID()
    let date: Date
    let count: Int

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
}

class LocalStore: NSObject {

    static let shared = LocalStore()

    @Persisted(userDefaultsKey: "isOnboarded", notificationName: .init("LocalStoreIsOnboardedDidChange"), defaultValue: false)
    var isOnboarded: Bool

    @Persisted(userDefaultsKey: "exposureSummaries", notificationName: .init("LocalStoreExposureSummariesDidChange"), defaultValue: [])
    var exposureSummaries: [ExposureSummary]

}

@propertyWrapper
class Persisted<Value: Codable> {

    init(userDefaultsKey: String, notificationName: Notification.Name, defaultValue: Value) {
        self.userDefaultsKey = userDefaultsKey
        self.notificationName = notificationName
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                wrappedValue = try JSONDecoder().decode(Value.self, from: data)
            } catch {
                wrappedValue = defaultValue
            }
        } else {
            wrappedValue = defaultValue
        }
    }

    let userDefaultsKey: String
    let notificationName: Notification.Name

    var wrappedValue: Value {
        didSet {
            // swiftlint:disable force_try
            UserDefaults.standard.set(try! JSONEncoder().encode(wrappedValue), forKey: userDefaultsKey)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
    }

    var projectedValue: Persisted<Value> { self }

    func addObserver(using block: @escaping () -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: nil) { _ in
            block()
        }
    }
}
