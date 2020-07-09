//
//  UserData.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import Foundation

class UserData: NSObject {

    static let shared = UserData()

    @Persisted(userDefaultsKey: "isOnboarded", notificationName: .init("LocalStoreIsOnboardedDidChange"), defaultValue: false)
    var isOnboarded: Bool

    @Persisted(userDefaultsKey: "userUuid", notificationName: .init("LocalStoreUserUuidDidChange"), defaultValue: "")
    var userUuid: String

    @Persisted(userDefaultsKey: "secret", notificationName: .init("LocalStoreSecretDidChange"), defaultValue: "")
    var secret: String

    @Persisted(userDefaultsKey: "jumpConsistentSeed", notificationName: .init("LocalStoreJumpConsistentSeedDidChange"), defaultValue: 0)
    var jumpConsistentSeed: Int

    @Persisted(userDefaultsKey: "startDateTime", notificationName: .init("LocalStoreStartDateTimeDidChange"), defaultValue: Date())
    var startDateTime: Date

    @Persisted(userDefaultsKey: "exposureSumary", notificationName: .init("LocalStoreExposureSumaryDidChange"), defaultValue: nil)
    var exposureSumary: UserExposureSummary?

    @Persisted(userDefaultsKey: "exposureInformation", notificationName: .init("LocalStoreExposureInformationDidChange"), defaultValue: [])
    var exposureInformation: [UserExposureInfo]

    @Persisted(userDefaultsKey: "positiveDiagnoses", notificationName: .init("LocalStorePositiveDiagnosesDidChange"), defaultValue: [])
    var positiveDiagnoses: [PositiveDiagnosisState]

    func add(diagnoses: PositiveDiagnosisState) {
        if diagnoses.diagnosisUid.isEmpty {
            fatalError()
        }

        if positiveDiagnoses.first(where: { $0.diagnosisUid == diagnoses.diagnosisUid }) != nil {
            // exsiting
            return
        }

        positiveDiagnoses.removeAll(where: { $0.shared == false })

        positiveDiagnoses.append(diagnoses)
    }

    func update(diagnoses: PositiveDiagnosisState) {
        positiveDiagnoses.removeAll(where: { $0.diagnosisUid == diagnoses.diagnosisUid })
        positiveDiagnoses.append(diagnoses)
    }

    func reset() {
        UserDefaults.standard.removeObject(forKey: "isOnboarded")
        UserDefaults.standard.removeObject(forKey: "userUuid")
        UserDefaults.standard.removeObject(forKey: "secret")
        UserDefaults.standard.removeObject(forKey: "jumpConsistentSeed")
        UserDefaults.standard.removeObject(forKey: "exposureSumary")
        UserDefaults.standard.removeObject(forKey: "exposureInformation")
        UserDefaults.standard.removeObject(forKey: "positiveDiagnoses")
        UserDefaults.standard.synchronize()
    }

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

    // swiftlint:disable force_try
    var wrappedValue: Value {
        didSet {
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
