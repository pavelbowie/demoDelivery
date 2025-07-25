//
//  PizzaCell.swift
//  demoDelivery
//
//  Created by Pavel Mac on 23.07.2025.
//

import UIKit


class PizzaCell: UITableViewCell {
    
    static let identifier = "PizzaCell"
    
    private let pizzaImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemPink
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemPink.cgColor
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(pizzaImageView)
        contentView.addSubview(stack)
        contentView.addSubview(priceLabel)

        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(descLabel)

        NSLayoutConstraint.activate([
            pizzaImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pizzaImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            pizzaImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            pizzaImageView.widthAnchor.constraint(equalToConstant: 132),
            pizzaImageView.heightAnchor.constraint(equalToConstant: 132),

            stack.leadingAnchor.constraint(equalTo: pizzaImageView.trailingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),

            priceLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            priceLabel.widthAnchor.constraint(equalToConstant: 87),
            priceLabel.heightAnchor.constraint(equalToConstant: 32),
        ])
    }

    func configure(with product: LaPizza) {
        pizzaImageView.image = UIImage(named: product.imageName)
        nameLabel.text = product.name
        descLabel.text = product.description
        priceLabel.text = " \(product.price) "
    }
}
