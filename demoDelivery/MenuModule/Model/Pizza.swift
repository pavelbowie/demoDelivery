//
//  FoodCategory.swift
//  demoDelivery
//
//  Created by Pavel Mac on 23.07.2025.
//

import Foundation


enum FoodCategory: String, CaseIterable, Decodable {
    case pizza = "Пицца"
    case combo = "Комбо"
    case desserts = "Десерты"
    case drinks = "Напитки"
}

struct LaPizza: Decodable {
    let name: String
    let description: String
    let price: String
    let imageName: String
    let category: FoodCategory
}
