//
//  PretendUser.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

public class PretendUser: Identifiable, Codable, Hashable {
    public var id: String
    public var email: String
    public var password: String
    
    init(id: String, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
    
    public static func == (lhs: PretendUser, rhs: PretendUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
