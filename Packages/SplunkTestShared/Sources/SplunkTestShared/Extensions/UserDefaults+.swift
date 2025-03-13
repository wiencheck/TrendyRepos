//
//  UserDefaults+.swift
//  SplunkTestShared
//
//  Created by Adam Wienconek on 13/03/2025.
//

import Foundation

public extension UserDefaults {
    
    var forceDarkMode: Bool {
        get {
            bool(forKey: "forcedarkmode")
        }
        set {
            set(newValue, forKey: "forcedarkmode")
        }
    }
    
}
