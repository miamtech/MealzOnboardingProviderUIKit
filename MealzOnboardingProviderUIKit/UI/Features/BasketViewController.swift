//
//  BasketViewController.swift
//  MealzOnboardingProviderUIKit
//
//  Created by Diarmuid McGonagle on 25/07/2024.
//

import UIKit

class BasketViewController: UIViewController {
    
    let basketLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelView()
    }

    func setupLabelView() {
        view.addSubview(basketLabel)
        basketLabel.text = "My Basket"
        basketLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basketLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            basketLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            basketLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

}
