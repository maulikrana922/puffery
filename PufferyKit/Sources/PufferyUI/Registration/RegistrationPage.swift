//
//  RegistrationPage.swift
//
//
//  Created by Valentin Knabel on 03.05.20.
//

import SwiftUI
import ComposableArchitecture

struct RegistrationPage: View {
    var onFinish: () -> Void

    @ObservedObject private var keyboard = Keyboard()
    let store: ComposableArchitecture.Store<RegistrationState, RegistrationAction>

    var body: some View {
        WithViewStore(self.store) { viewModel in
            VStack {
                Spacer()

                Button(action: { viewModel.send(.shouldRegister(onFinish: self.onFinish)) }) {
                    Text("GettingStarted.Registration.Anonymous")
                }.buttonStyle(RoundedButtonStyle())
                    .show(when: !self.keyboard.isActive)
                    .transition(.opacity)
                    .disabled(viewModel.activity.inProgress)

                Spacer()

                HStack {
                    VStack { Divider() }
                    Text("OR")
                        .italic()
                        .font(.headline)
                    VStack { Divider() }
                }.show(when: !self.keyboard.isActive).transition(.opacity)

                VStack {
                    TextField("GettingStarted.Login.EmailPlaceholder", text: Binding(get: {viewModel.email}, set: {viewModel.send(.updateEmail($0))}), onCommit: { viewModel.send(.shouldRegister(onFinish: self.onFinish)) })
                        .textFieldStyle(RoundedTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .disabled(viewModel.activity.inProgress)

                    Button(action: { viewModel.send(.shouldLogin(onFinish: self.onFinish)) }) {
                        Text("GettingStarted.Login.Perform")
                    }
                    .disabled(viewModel.email.isEmpty || viewModel.activity.inProgress)
                    .sheet(isPresented: viewModel.binding(
                            get: { $0.shouldCheckEmails },
                            send: RegistrationAction.showCheckEmails
                        )
                    ) {
                        EmailConfirmationPage(email: viewModel.email)
                    }
                }
                .padding()
                .padding(.bottom, self.keyboard.currentHeight)
                .animation(.default)

                Spacer()
            }.buttonStyle(RoundedButtonStyle())
        }
    }
}

#if DEBUG
    struct RegistrationPage_Previews: PreviewProvider {
        static var previews: some View {
            RegistrationPage(onFinish: {}, store: ComposableArchitecture.Store<RegistrationState, RegistrationAction>(
                initialState: RegistrationState(),
                reducer: registrationReducer,
                environment: RegistrationEnvironment.live()
            ))
        }
    }
#endif