//
//  BannerHider.swift
//  demoDelivery
//
//  Created by Pavel Mac on 23.07.2025.
//

import UIKit


final class BannerHider {
    
    private weak var scrollView: UIScrollView?
    private weak var bannerView: UIView?
    private weak var pinnedView: UIView?
    
    private var isBannerHidden = false
    private let bannerHeight: CGFloat

    private var tableViewTopConstraint: NSLayoutConstraint?

    init(scrollView: UIScrollView,
         bannerView: UIView,
         pinnedView: UIView,
         bannerHeight: CGFloat,
         tableViewTopConstraint: NSLayoutConstraint? = nil) {
        
        self.scrollView = scrollView
        self.bannerView = bannerView
        self.pinnedView = pinnedView
        self.bannerHeight = bannerHeight
        self.tableViewTopConstraint = tableViewTopConstraint

        scrollView.panGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let scrollView = scrollView else { return }
        let velocity = gesture.velocity(in: scrollView)
        
        switch gesture.state {
        case .changed:
            if velocity.y < -100 {
                hideBanner()
            } else if velocity.y > 100 {
                showBanner()
            }
        default:
            break
        }
    }
    
    private func hideBanner() {
        guard !isBannerHidden,
              let banner = bannerView,
              let pinned = pinnedView
        else { return }

        isBannerHidden = true

        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            banner.alpha = 0
            banner.transform = CGAffineTransform(translationX: 0, y: -self.bannerHeight)
            pinned.transform = CGAffineTransform(translationX: 0, y: -self.bannerHeight)
            self.tableViewTopConstraint?.constant -= self.bannerHeight
            banner.superview?.layoutIfNeeded()
        }
    }
    
    private func showBanner() {
        guard isBannerHidden,
              let banner = bannerView,
              let pinned = pinnedView
        else { return }

        isBannerHidden = false

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            banner.alpha = 1
            banner.transform = .identity
            pinned.transform = .identity
            self.tableViewTopConstraint?.constant += self.bannerHeight
            banner.superview?.layoutIfNeeded()
        }
    }
}
