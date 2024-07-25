//
//  MealzManager.swift
//  MealzOnboardingProviderUIKit
//
//  Created by Diarmuid McGonagle on 25/07/2024.
//

import Foundation
import mealzcore
import MarmitonUIMealzIOS
import UIKit

// TODO: 9. Use Marmiton Components
// 9a. Create Mealz Config File & Struct
// 9b. Copy & paste boilerplate for View Options
// 9c. Enter Marmiton Custom Views
// 9d. Pass View Config to RecipeDetails
// 9e. Pass View Config to MyBasket

// 2a. Create MealzManager File
public class MealzManager: ObservableObject {
    public static let sharedInstance = MealzManager()
    
    // TODO: 3. Set SupplierKey, Store & User Id

    // TODO 3a. Copy & paste supplierID into variable
    let providerKey = "ewogICAgICAgICJwcm92aWRlcl9pZCI6ICJtYXJtaXRvbiIKCSJwbGF1c2libGVfZG9tYWluZSI6ICJtaWFtLm1hcm1pdG9uLmFwcCIsCgkibWlhbV9vcmlnaW4iOiAibWFybWl0b24iLAoJIm9yaWdpbiI6ICJtaWFtLm1hcm1pdG9uLmFwcCIsCgkibWlhbV9lbnZpcm9ubWVudCI6ICJVQVQiCn0="
    // TODO 3b. Init Mealz
    private init() {
        Mealz.shared.Core(init: { coreBuilder in
            // set supplier key
            coreBuilder.sdkRequirement(init: { [self] requirementBuilder in
                requirementBuilder.key = providerKey
            })
            // TODO 3c. Allow authless users
            coreBuilder.option(init: { config in
                config.isAnonymousModeEnabled = true
            })
        })
        // 5c. update MealzManager
        Mealz.shared.user.setStoreLocatorRedirection {
            changeStore()
        }
    }
   
    // TODO 3d. Create function to set the user
    func updateUserId(userId: String?) {
        Mealz.shared.user.updateUserId(userId: userId, authorization: Authorization.userId)
    }
    
    // TODO: 5. Set chooseStoreRedirct
}

// TODO 5a. create function to choose store
let changeStore: () -> Void = {
    // TODO 5b. use MealzWebview
    let htmlFileURL =  MarmitonUIMealzIOS.bundle.url(forResource: "index", withExtension: "html", subdirectory: "Ressources")!

        var mealsWebView =  MealzStoreLocatorWebView(url:htmlFileURL) { value in
            guard let posId = value as? String else { return }
        }
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let keyWindow = sceneDelegate.windows.first(where: { $0.isKeyWindow }),
           let rootViewController = keyWindow.rootViewController {

            // Find the topmost view controller which is not presenting another view controller
            var topViewController = rootViewController
            while let presentedViewController = topViewController.presentedViewController {
                topViewController = presentedViewController
            }

            // Present the new view controller from the topmost view controller
            topViewController.present(mealsWebView, animated: true)
        }
}
