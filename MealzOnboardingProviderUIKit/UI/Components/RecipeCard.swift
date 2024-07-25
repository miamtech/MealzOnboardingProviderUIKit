//
//  RecipeCard.swift
//  MealzOnboardingProviderUIKit
//
//  Created by Diarmuid McGonagle on 25/07/2024.
//

import UIKit
import SwiftUI
import Combine
// TODO 7a. Import Mealz package
import mealzcore

class PretendRecipe {
    let externalId: String
    let title: String
    let imageUrl: String
    
    init(externalId: String, title: String, imageUrl: String) {
        self.externalId = externalId
        self.title = title
        self.imageUrl = imageUrl
    }
}

protocol RecipeCardViewDelegate: AnyObject {
    func didTapSeeDetailsButton(recipeId: String)
}


class RecipeCardView: UIView {
    
    weak var delegate: RecipeCardViewDelegate?
    
    var recipe: PretendRecipe? {
        didSet {
            guard let recipe = recipe else { return }
            titleLabel.text = recipe.title
            setImage()
        }
    }
    
    func configure(with recipe: PretendRecipe) {
        self.recipe = recipe
    }

    let background = UIView()
    let productImageView = UIImageView()
    let titleLabel = UILabel()
    let getPriceButton = UIButton(type: .system)
    var priceOfRecipe: String? = nil
    let openDetailsButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCard()
    }
    
    private func setImage() {
        if let imageUrl = recipe?.imageUrl {
            productImageView.downloaded(from: imageUrl)
        }
        addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        productImageView.image = UIImage(named: "Home")
        let url = URL(string: recipe?.imageUrl ?? "")
        
        DispatchQueue.global().async {
            if let url = url {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.productImageView.image = UIImage(data: data!)
                }
            }
        }
    }
        
    private func setupCard() {
        backgroundColor = .yellow
       
        addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.image = UIImage(named: "Home")
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        productImageView.contentMode = .scaleAspectFit
        
        
        
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0 // Allows label to wrap text
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
    
        
        addSubview(getPriceButton)
        getPriceButton.setTitle(priceOfRecipe ?? "Get Price", for: .normal)
        getPriceButton.tintColor = .blue
        getPriceButton.translatesAutoresizingMaskIntoConstraints = false
        getPriceButton.addTarget(self, action: #selector(getPrice), for: .touchUpInside)
        NSLayoutConstraint.activate([
            getPriceButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            getPriceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            getPriceButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        addSubview(openDetailsButton)
        openDetailsButton.translatesAutoresizingMaskIntoConstraints = false
        openDetailsButton.setTitle("See Details", for: .normal)
        openDetailsButton.tintColor = .blue
        openDetailsButton.addTarget(self, action: #selector(launchRecipeDetails), for: .touchUpInside)
        NSLayoutConstraint.activate([
            openDetailsButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            openDetailsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            openDetailsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func launchRecipeDetails() {
        if let recipeId = self.recipe?.externalId {
            delegate?.didTapSeeDetailsButton(recipeId: recipeId)
        }
    }
    
    // TODO: 7. Get Price for Recipe
    @objc func getPrice() {
        // TODO 7d. Prohibit button called if price returned
        if self.priceOfRecipe == nil, let recipeId = recipe?.externalId {
            Task {
                do {
                    // TODO 7b. Call Mealz function to get price
                    let price = try await Mealz.shared.recipe.getPriceOrRedirect(recipeId: recipeId, numberOfGuest: 4).await()
                    let priceOfRecipe = price as? Double ?? 0
                    if priceOfRecipe == 0.0 { return }
                    // TODO 7c. Update title when price returned
                    DispatchQueue.main.async { [weak self] in
                        self?.priceOfRecipe = String(priceOfRecipe)
                        self?.getPriceButton.setTitle(self?.priceOfRecipe, for: .normal)
                    }
                }
            }
        }
    }
}
