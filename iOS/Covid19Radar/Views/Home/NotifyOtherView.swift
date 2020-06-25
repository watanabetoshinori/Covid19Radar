//
//  NotifyOtherView.swift
//  Covid19Radar
//
//  Created by Watanabe Toshinori on 2020/06/25.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct NotifyOtherView: View {

    @ObservedObject var viewModel = NotifyOtherViewModel()

    @Binding var isParentPresented: Bool

    @State var isPresented = false

    @State var keyboardHeight: CGFloat = 0

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("NotifyOtherPageDescription1")
                        .defaultLabel()

                    NavigationLink(destination: Help3View()) {
                        Text("NotifyOtherPageLabel")
                    }
                    .foregroundColor(.accentColor)

                    TextField("NotifyOtherPageLabel2", text: self.$viewModel.diagnosisUID)
                        .font(self.viewModel.diagnosisUID.isEmpty ? .body : .title)
                        .keyboardType(.numberPad)
                        .padding(.horizontal)
                        .frame(minHeight: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(UIColor.systemGray), lineWidth: 2)
                        )

                    Text("NotifyOtherPageDescription2")
                        .defaultLabel()
                        .padding()
                        .background(Color("ContanctedNotify"))
                        .cornerRadius(8)

                    Spacer()

                    LargeActionButton(label: "NotifyOtherPageButton", action: self.viewModel.submit)

                    NavigationLink(destination: ThankYouNotifyOtherView(isParentPresented: self.$isParentPresented),
                                   isActive: self.$isPresented) {
                        Rectangle()
                    }
                    .isDetailLink(false)
                    .frame(height: 0)
                }
                .padding()
                .frame(minHeight: proxy.size.height)
                .padding(.bottom, self.keyboardHeight)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarTitle("NotifyOtherPageTitle", displayMode: .inline)
        .onReceive(self.viewModel.$isPresented, perform: { (newValue) in
            withAnimation {
                self.isPresented = newValue
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification),
                   perform: self.keyboardWillChange)
        .onTapGesture(perform: {
            UIApplication.shared.windows.first?.endEditing(true)
        })
    }

    private func keyboardWillChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardFrame = keyboardFrameValue.cgRectValue
        keyboardHeight = keyboardFrame.height
    }

}

struct NotifyOtherView_Previews: PreviewProvider {
    static var previews: some View {
        NotifyOtherView(isParentPresented: .constant(true))
    }
}
