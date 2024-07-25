//
//  MealzManager.swift
//  MealzOnboardingProviderUIKit
//
//  Created by Diarmuid McGonagle on 25/07/2024.
//

import Foundation
import mealzcore

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
    }
   
    // TODO 3d. Create function to set the user
    func updateUserId(userId: String?) {
        Mealz.shared.user.updateUserId(userId: userId, authorization: Authorization.userId)
    }
}
