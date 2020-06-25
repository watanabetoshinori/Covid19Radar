//
//  SettingsView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    @ObservedObject var viewModel = SettingsViewModel()

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    self.exposureRow
                    self.notificationRow
                    self.versionRow
                    self.licenseRow
                    self.resetRow
                }
                .padding(.top, 8)
                .frame(width: proxy.size.width)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("SettingsPageTitle", displayMode: .inline)
    }

    // MARK: - Rows

    var exposureRow: some View {
        Group {
            Toggle(isOn: self.$viewModel.isExposureEnabled) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("SettingsPageLabel1")
                        .defaultLabel()

                    Text("SettingsPageDescription1")
                        .foregroundColor(.secondary)
                        .defaultSubLabel()
                }
            }
            .padding(.horizontal)

            Divider()
        }
    }

    var notificationRow: some View {
        Group {
            Toggle(isOn: self.$viewModel.isNotificationEnabled) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("SettingsPageLabel2")
                        .defaultLabel()

                    Text("SettingsPageDescription2")
                        .foregroundColor(.secondary)
                        .defaultSubLabel()
                }
            }
            .padding(.horizontal)

            Divider()
        }
    }

    var versionRow: some View {
        Group {
            HStack(spacing: 8) {
                Text("VersionText")
                    .defaultLabel()

                Spacer()

                Text(viewModel.version)
                    .foregroundColor(.secondary)
                    .defaultLabel()
            }
            .padding(.horizontal)
            .padding(.vertical, 4)

            Divider()
        }
    }

    var licenseRow: some View {
        Group {
            NavigationLink(destination: LicenseView()) {
                Text("SettingsPageButton1")
                    .defaultLabel()

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(Color(UIColor.systemGray3))
            }
            .foregroundColor(.primary)
            .padding(.horizontal)
            .padding(.vertical, 4)

            Divider()
        }
    }

    var resetRow: some View {
        Group {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("SettingsPageLabel3")
                        .defaultLabel()

                    Text("SettingsPageDescription3")
                        .foregroundColor(.secondary)
                        .defaultSubLabel()
                }

                Spacer()

                SmallActionButton(label: "ButtonReset", action: viewModel.reset)
                    .frame(width: 90)
            }
            .padding(.horizontal)

            Divider()
        }
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
