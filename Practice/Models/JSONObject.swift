//
//  JSONObject.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/14/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

class JSONObject: NSObject{
    
    class var object: TwitObject.object {
        get {
            assert(false, "Must override this property with FIR.object type")
            return TwitObject.object.profile
        }
    }
    
    let json: [String: AnyObject]
    init(_ response: Any) {
        json = response as! [String: AnyObject]
    }
    
    
    
}
