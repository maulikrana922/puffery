//
//  GettingStartedPage.swift
//  Puffery
//
//  Created by Valentin Knabel on 19.04.20.
//  Copyright © 2020 Valentin Knabel. All rights reserved.
//

import SwiftUI
import UserNotifications
import APIDefinition

struct GettingStartedPage: View {
    var onFinish: () -> Void

    @State var registrationInProgress = false
    @State var registrationError: FetchingError?

    var body: some View {
        Waves {
            RegistrationPage(onFinish: self.onFinish)
        }
//        VStack {
//            Button(action: registerForPushNotifications) {
//                Text("GettingStarted.Registration.Anonymous")
//            }.disabled(registrationInProgress).onAppear { Current.tracker.record("GettingStartedPage") }
//                .alert(item: $registrationError) { error in
//                    Alert(title: Text("GettingStarted.Registration.Failed"), message: Text(error.localizedDescription))
//                }
//            LoginView(onFinish: onFinish)
//        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
//        }
    }
}

#if DEBUG
    struct GettingStarted_Previews: PreviewProvider {
        static var previews: some View {
            GettingStartedPage(onFinish: {})
        }
    }
#endif