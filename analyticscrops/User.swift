//
//  User.swift
//  analyticscrops
//
//  Created by Veevart on 5/20/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit

class User: NSObject {
    var CreateDate:String?
    var CreatedBy:String?
    var Email:String?
    var FirstName:String?
    var LastName:String?
    var ModifiedBy:String?
    var ModifiedDate:String?
    var Name:String?
    var Phone:NSNumber?
    var Profile:String?
    var Title:String?
    var Id:String?
    
    init(dictionary: [String: AnyObject]) {
        self.CreateDate = dictionary["CreateDate"] as? String
        self.CreatedBy = dictionary["CreatedBy"] as? String
        self.Email = dictionary["Email"] as? String
        self.FirstName = dictionary["FirstName"] as? String
        self.LastName = dictionary["LastName"] as? String
        self.ModifiedBy = dictionary["ModifiedBy"] as? String
        self.ModifiedDate = dictionary["ModifiedDate"] as? String
        self.Name = dictionary["Name"] as? String
        self.Phone = dictionary["Phone"] as? NSNumber
        self.Profile = dictionary["Profile"] as? String
        self.Title = dictionary["Title"] as? String
    }
}
