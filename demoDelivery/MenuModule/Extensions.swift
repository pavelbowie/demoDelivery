//
//  Extensions.swift
//  demoDelivery
//
//  Created by Pavel Mac on 24.07.2025.
//

import Foundation
import UIKit


extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollection {
            return banners.count
        } else {
            print("categories count: \(categories.count)")
            return categories.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            cell.configure(with: banners[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.configure(with: categories[indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollection {
            return CGSize(width: 300, height: 112)
        } else {
            let text = categories[indexPath.item].name
            let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 74
            return CGSize(width: width, height: 32)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = sortedCategories[indexPath.item]
        
        if let sectionIndex = sortedCategories.firstIndex(of: category) {
            let indexPath = IndexPath(row: 0, section: sectionIndex)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedCategories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = sortedCategories[section]
        return pizzasByCategory[category]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = sortedCategories[indexPath.section]
        guard let pizza = pizzasByCategory[category]?[indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaCell", for: indexPath) as! PizzaCell
        cell.configure(with: pizza)
        return cell
    }
}
