//
//  UserSession.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class UserSession: ObservableObject {
    public static let sharedInstance = UserSession()
    
    @Published var user: PretendUser?
    
    let userRepository = PretendUserRepository()
    
    init() {
        if let user = userRepository.getStoredUser() { setUser(user: user) }
    }
    
    func disconnectUser() {
        setUser(user: nil)
        userRepository.deleteStoredUser()
    }
    
    func setUser(user: PretendUser?) {
        self.user = user
        // TODO 3e. Call Mealz Function
    }
}
