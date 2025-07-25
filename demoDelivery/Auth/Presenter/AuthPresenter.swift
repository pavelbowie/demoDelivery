//
//  AuthPresenter.swift
//  demoDelivery
//
//  Created by Pavel Mac on 22.07.2025.
//

import Foundation


protocol AuthViewProtocol: AnyObject {
    func showAuthSuccess()
    func showAuthError(message: String)
}

class AuthPresenter {
    weak var view: AuthViewProtocol?

    init(view: AuthViewProtocol) {
        self.view = view
    }

    func loginTapped(username: String?, password: String?) {
        guard let login = username, !login.isEmpty,
              let password = password, !password.isEmpty else {
            view?.showAuthError(message: "Пожалуйста, заполните все поля")
            return
        }

        let credentials = UserCredentials(login: login, password: password)

        if credentials.isValid() {
            view?.showAuthSuccess()
        } else {
            view?.showAuthError(message: "Неверный логин или пароль\nИспользуйте логин 1 и пароль 1")
        }
    }
}
