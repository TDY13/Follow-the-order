//
//  UserDefaultsManager.swift
//  FollowTheOrderTestTask
//
//  Created by DiOS on 14.10.2022.
//

import UIKit

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    
    private let lvlNumberKey = "lvlNumber"
    
    var lvlNumber: Int {
        get {
            return UserDefaults.standard.integer(forKey: lvlNumberKey)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: lvlNumberKey)
            UserDefaults.standard.synchronize()
        }
    }
}
