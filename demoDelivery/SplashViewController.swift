//
//  SplashViewController.swift
//  demoDelivery
//
//  Created by Pavel Mac on 23.07.2025.
//

import UIKit


class SplashViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logoLaPizzaWhite"))
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPink
        setupLayout()
        fadeIn()
    }

    private func setupLayout() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func fadeIn() {
        UIView.animate(withDuration: 0.5, animations: {
            self.logoImageView.alpha = 1
        }) { _ in
            self.goToAuthAfterDelay()
        }
    }

    private func goToAuthAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fadeOutAndNavigate()
        }
    }

    private func fadeOutAndNavigate() {
        UIView.animate(withDuration: 0.3, animations: {
        }) { _ in
            let authVC = AuthViewController()
            authVC.modalPresentationStyle = .fullScreen

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = authVC
                window.makeKeyAndVisible()
            } else {
                self.present(authVC, animated: false)
            }
        }
    }
}
