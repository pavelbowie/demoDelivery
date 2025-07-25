//
//  AuthViewController.swift
//  demoDelivery
//
//  Created by Pavel Mac on 22.07.2025.
//

import Foundation
import UIKit


final class AuthViewController: UIViewController, AuthViewProtocol {

    private var loginButtonBottomConstraint: NSLayoutConstraint!
    private var centerStackViewCenterYConstraint: NSLayoutConstraint!

    private var presenter: AuthPresenter!
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoLaPizzaPink")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        presenter = AuthPresenter(view: self)
        setupUI()
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupUI() {
        usernameTextField.placeholder = "Логин"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.autocapitalizationType = .none
        usernameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        usernameTextField.setLeftView(image: UIImage.init(named: "icon-user")!)

        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        passwordTextField.setLeftView(image: UIImage.init(named: "icon-password")!)

        logoImageView.heightAnchor.constraint(equalToConstant: 103).isActive = true

        let centerStackView = UIStackView(arrangedSubviews: [
            logoImageView,
            usernameTextField,
            passwordTextField
        ])
        centerStackView.axis = .vertical
        centerStackView.spacing = 20
        centerStackView.alignment = .fill
        centerStackView.distribution = .fill

        centerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerStackView)

        centerStackViewCenterYConstraint = centerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        NSLayoutConstraint.activate([
            centerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            centerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            centerStackViewCenterYConstraint
        ])

        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = .systemPink
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 24
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)

        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        loginButtonBottomConstraint = loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)

        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButtonBottomConstraint
        ])
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }

        let bottomInset = keyboardFrame.height - view.safeAreaInsets.bottom

        UIView.animate(withDuration: duration) {
            self.loginButtonBottomConstraint.constant = -bottomInset - 20
            self.centerStackViewCenterYConstraint.constant = -150 
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }

        UIView.animate(withDuration: duration) {
            self.loginButtonBottomConstraint.constant = -40
            self.centerStackViewCenterYConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }

    
    @objc private func loginPressed() {
        presenter.loginTapped(username: usernameTextField.text, password: passwordTextField.text)
    }

    func showAuthSuccess() {
        showCustomAlert(message: "Вход выполнен успешно", isSuccess: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let tabBar = TabBarController()
            tabBar.modalPresentationStyle = .fullScreen

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = tabBar
                window.makeKeyAndVisible()
            } else {
                self.present(tabBar, animated: true)
            }
        }
    }

    func showAuthError(message: String) {
        showCustomAlert(message: message, isSuccess: false)
    }

    func showCustomAlert(message: String, isSuccess: Bool) {
        let alertView = UIView()
        alertView.backgroundColor = isSuccess ? UIColor.systemGreen : UIColor.systemPink
        alertView.layer.cornerRadius = 20
        alertView.layer.masksToBounds = true
        alertView.alpha = 0

        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)

        alertView.addSubview(label)
        view.addSubview(alertView)

        alertView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -12),
            label.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -12)
        ])

        UIView.animate(withDuration: 0.3) {
            alertView.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.3, animations: {
                alertView.alpha = 0
            }) { _ in
                alertView.removeFromSuperview()
            }
        }
    }
}


extension UITextField {
    func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 14, y: 10, width: 16, height: 16))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .systemPink
    }
}
