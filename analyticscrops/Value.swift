//
//  Value.swift
//  analyticscrops
//
//  Created by Veevart on 5/25/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit

class Value: NSObject {
    var Date: String?
    var Value: Double?
    
    init(dictionary: [String: AnyObject]) {
        self.Date = dictionary["Date"] as? String
        self.Value = dictionary["Value"] as? Double
    }
}
