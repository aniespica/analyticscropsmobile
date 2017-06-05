//
//  Lote.swift
//  analyticscrops
//
//  Created by Veevart on 5/21/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit

class Lote: NSObject {
    var Area: NSNumber?
    var CreateBy: String?
    var CreateDate: String?
    var FieldCapacity: NSNumber?
    var FieldType: String?
    var Lara: NSNumber?
    var ModifyBy: String?
    var Id: String?
    var ModifyDate: String?
    var Name: String?
    var StartDate: String?
    var Variables: AnyObject?
    var ParentId: String?
    
    init(dictionary: [String: AnyObject]) {
        self.Area = dictionary["Area"] as? NSNumber
        self.CreateBy = dictionary["CreateBy"] as? String
        self.CreateDate = dictionary["CreateDate"] as? String
        self.FieldCapacity = dictionary["FieldCapacity"] as? NSNumber
        self.FieldType = dictionary["FieldType"] as? String
        self.Lara = dictionary["Lara"] as? NSNumber
        self.ModifyBy = dictionary["ModifyBy"] as? String
        self.ModifyDate = dictionary["ModifyDate"] as? String
        self.Name = dictionary["Name"] as? String
        self.StartDate = dictionary["StartDate"] as? String
        self.Variables = dictionary["Variables"]
        self.Id = dictionary["Id"] as? String
        self.ParentId = dictionary["ParentId"] as? String
    }
}
