//
//  Presenter.swift
//  demoDelivery
//
//  Created by Pavel Mac on 23.07.2025.
//

import Foundation


protocol MenuViewProtocol: AnyObject {
    func displayLaPizzaByCategory(_ grouped: [FoodCategory: [LaPizza]])
    func displayBanners(_ banners: [Banner])
    func displayCategories(_ categories: [Category])
}

class LaPizzaPresenter {
    
    weak var view: MenuViewProtocol?
    
    init(view: MenuViewProtocol) {
        self.view = view
    }
    
    func loadContent() {
        guard let pizzas = loadMockDataFromJSON() else {
            view?.displayLaPizzaByCategory([:])
            return
        }

        let banners = [
            Banner(imageName: "slide-01"),
            Banner(imageName: "slide-02")
        ]
        
        let categories = [
            Category(name: "Пицца", isSelected: true),
            Category(name: "Комбо", isSelected: false),
            Category(name: "Десерты", isSelected: false),
            Category(name: "Напитки", isSelected: false)
        ]
        
        view?.displayBanners(banners)
        view?.displayCategories(categories)
        let grouped = Dictionary(grouping: pizzas, by: { $0.category })
              view?.displayLaPizzaByCategory(grouped)
    }
}
