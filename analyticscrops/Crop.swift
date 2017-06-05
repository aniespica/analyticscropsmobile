//
//  Crop.swift
//  analyticscrops
//
//  Created by Veevart on 5/20/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit

class Crop: NSObject {
    var CreateDate:String?
    var CreatedBy:String?
    var Area:NSNumber?
    var CropVariety:String?
    var FieldCapacity:NSNumber?
    var ModifiedBy:String?
    var ModifiedDate:String?
    var Name:String?
    var IrrigationType:String?
    var Lara:NSNumber?
    var Lotes:[Lote]?
    var Id:String?
    var StartDate:String?
    var isCalculate:Bool?
    
    init(dictionary: [String: AnyObject]) {
        self.CreateDate = dictionary["CreateDate"] as? String
        self.CreatedBy = dictionary["CreatedBy"] as? String
        self.Area = dictionary["Area"] as? NSNumber
        self.CropVariety = dictionary["CropVariety"] as? String
        self.FieldCapacity = dictionary["FieldCapacity"] as? NSNumber
        self.ModifiedBy = dictionary["ModifiedBy"] as? String
        self.ModifiedDate = dictionary["ModifiedDate"] as? String
        self.Name = dictionary["Name"] as? String
        self.IrrigationType = dictionary["IrrigationType"] as? String
        self.Lara = dictionary["Lara"] as? NSNumber
        
        
        if dictionary["Lotes"] != nil {
            var lotes = [Lote]()
            
            for (key, theValue) in dictionary["Lotes"] as! [String: AnyObject] {
                var emptyDict: [String: AnyObject] = theValue as! [String : AnyObject]
                emptyDict["Id"] = key as AnyObject?
                let lote = Lote(dictionary: emptyDict)
                lotes.append(lote)
            }
            
            self.Lotes = lotes as [Lote]?
        }
       
        
        
        self.Id = dictionary["Id"] as? String
        self.StartDate = dictionary["StartDate"] as? String
        self.isCalculate = dictionary["isCalculate"] as? Bool
    }
}
