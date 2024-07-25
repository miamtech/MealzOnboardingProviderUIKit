//
//  PretendUserLocalDS.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class PretendUserLocalDS {
    // Key for storing the user in UserDefaults
    private let userKey = "com.mealz.PretendUser"

    func saveUserToLocalStorage(user: PretendUser) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: userKey)
        }
    }

    func loadUserFromLocalStorage() -> PretendUser? {
        if let savedUserData = UserDefaults.standard.data(forKey: userKey) {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(PretendUser.self, from: savedUserData) {
                return loadedUser
            }
        }
        return nil
    }
    
    func deleteUserFromLocalStorage() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}
