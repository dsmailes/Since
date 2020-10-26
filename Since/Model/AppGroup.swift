//
//  AppGroup.swift
//  Since
//
//  Created by David Smailes on 26/10/2020.
//

import Foundation

public enum AppGroup: String {
    
    case since = "group.com.mylearningapps.since"
    
    public var containerURL: URL {
        switch self {
        case .since:
            return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: self.rawValue)!
        }
    }
    
}
