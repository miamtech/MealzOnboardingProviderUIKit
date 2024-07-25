//
//  PretendUserRepository.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class PretendUserRepository {
    private let localDataSource: PretendUserLocalDS
    
    init(localDataSource: PretendUserLocalDS = PretendUserLocalDS()) {
        self.localDataSource = localDataSource
    }
    
    func signInUser(user: PretendUser) {
        // make API request
        localDataSource.saveUserToLocalStorage(user: user)
    }
    
    func getStoredUser() -> PretendUser? {
        localDataSource.loadUserFromLocalStorage()
    }
    
    func deleteStoredUser() {
        localDataSource.deleteUserFromLocalStorage()
    }
}
