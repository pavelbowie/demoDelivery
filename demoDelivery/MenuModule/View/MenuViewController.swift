//
//  ViewController.swift
//  demoDelivery
//
//  Created by Pavel Mac on 23.07.2025.
//

import UIKit


final class MenuViewController: UIViewController, MenuViewProtocol {
    private var bannerHider: BannerHider?
    private var presenter: LaPizzaPresenter!
    var pizzasByCategory: [FoodCategory: [LaPizza]] = [:]
    var sortedCategories: [FoodCategory] = FoodCategory.allCases
    private var tableViewTopConstraint: NSLayoutConstraint!
    var banners: [Banner] = []
    var categories: [Category] = []
    var categoryHeaderView: UIView!
    let bannerCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let categoryCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LaPizzaPresenter(view: self)
        
        setupUI()
        
        bannerHider = BannerHider(
            scrollView: tableView,
            bannerView: bannerCollection,
            pinnedView: categoryCollection,
            bannerHeight: 120,
            tableViewTopConstraint: tableViewTopConstraint
        )
        
        presenter.loadContent()
    }
    
    func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "Меню"
        
        setupBannerCollection()
        setupCategoryCollection()
        setupTableView()
        
        let stack = UIStackView(arrangedSubviews: [bannerCollection, categoryCollection, tableView])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bannerCollection.heightAnchor.constraint(equalToConstant: 120),
            categoryCollection.heightAnchor.constraint(equalToConstant: 44),
            categoryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
        
        tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 16)
        
        NSLayoutConstraint.activate([
            tableViewTopConstraint,
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBannerCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        bannerCollection.backgroundColor = .clear
        bannerCollection.collectionViewLayout = layout
        bannerCollection.dataSource = self
        bannerCollection.delegate = self
        bannerCollection.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        bannerCollection.showsHorizontalScrollIndicator = false
    }
    
    private func setupCategoryCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        categoryCollection.backgroundColor = .clear
        categoryCollection.collectionViewLayout = layout
        categoryCollection.dataSource = self
        categoryCollection.delegate = self
        categoryCollection.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        categoryCollection.showsHorizontalScrollIndicator = false
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PizzaCell.self, forCellReuseIdentifier: "PizzaCell")
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = 16
    }
    
    func displayLaPizzaByCategory(_ grouped: [FoodCategory: [LaPizza]]) {
        self.pizzasByCategory = grouped
        tableView.reloadData()
    }
    
    func displayBanners(_ banners: [Banner]) {
        self.banners = banners
        bannerCollection.reloadData()
    }
    
    func displayCategories(_ categories: [Category]) {
        self.categories = categories
        categoryCollection.reloadData()
    }
}

