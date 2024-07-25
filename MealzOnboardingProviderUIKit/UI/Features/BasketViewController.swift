//
//  BasketViewController.swift
//  MealzOnboardingProviderUIKit
//
//  Created by Diarmuid McGonagle on 25/07/2024.
//

import UIKit
// TODO 6a. Import Nav
import MealzNaviOSSDK

// TODO: 6. Show MyBasket

class BasketViewController: UIViewController {
    
    let basketLabel = UILabel()
    // TODO 6b. Add MyBasket component
    var mealzMyBasket: MealzMyBasketFeatureUIKit?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: 8. Checkout
        // TODO 8a. Create function to show the checkout
        // TODO 8b. Use MealzMarmiton Webview
        // TODO 8c. Pass in function to MyBasketFeatureConstructor
        
        mealzMyBasket = MealzMyBasketFeatureUIKit(
            hideTitles: true,
            myBasketContructor: MyBasketFeatureConstructor(
                navigateToCatalog: { print("navigate to catalog") },
                navigateToCheckout: { _ in print("navigate to checkout") })
        )
        
        if let mealzMyBasket {
            // Add the custom navigation controller as a child view controller
            addChild(mealzMyBasket)
            mealzMyBasket.view.frame = self.view.bounds
            view.addSubview(mealzMyBasket.view)
            mealzMyBasket.didMove(toParent: self)
        }
        
//        setupLabelView()
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
