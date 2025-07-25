//
//  LoadManager.swift
//  demoDelivery
//
//  Created by Pavel Mac on 23.07.2025.
//

import Foundation


func loadMockDataFromJSON() -> [LaPizza]? {
    guard let url = Bundle.main.url(forResource: "mockdata", withExtension: "json") else {
        print("mockdata.json missing in bundle")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let pizzas = try JSONDecoder().decode([LaPizza].self, from: data)
        return pizzas
    } catch {
        print("Error Parse JSON: \(error)")
        return nil
    }
}
