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
        
        mealzMyBasket = MealzMyBasketFeatureUIKit(
            hideTitles: true,
            myBasketContructor: MyBasketFeatureConstructor(
                navigateToCatalog: { print("navigate to catalog") },
                navigateToCheckout: { urlString in
                    // TODO 8c. Pass in function to MyBasketFeatureConstructor
                    showCheckout(urlString)
                })
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

// TODO 8a. Create function to show the checkout
let showCheckout: (_ url: String?) -> Void = { urlString in
    
    guard let urlString = urlString else { return }
    guard let url = URL(string: urlString) else { return }
    // TODO 8b. Use MealzMarmiton Webview
    let viewController = TransferBasketFeature(transferBasketUrl: url, retailerName: "toto").toUIKit()
    viewController.modalPresentationStyle = .overCurrentContext
    
    if let sceneDelegate = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
        let keyWindow = sceneDelegate.windows.first(where: { $0.isKeyWindow }),
        let rootViewController = keyWindow.rootViewController
    {
        var topViewController = rootViewController
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        topViewController.present(viewController, animated: true)
    }
}
