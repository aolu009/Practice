//
//  TwitServer.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/14/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

class TwitObject: NSObject{
    
    enum object {
        case tweet, profile
        
        func key() -> String {
            switch self {
            case .tweet:
                return "tweet"
            case .profile:
                return "profile"
            }
        }
    }
}
