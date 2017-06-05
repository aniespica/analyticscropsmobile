//
//  Variable.swift
//  analyticscrops
//
//  Created by Veevart on 5/24/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit

class Variable: NSObject {
    var Values: [Value]?
    var CreateBy: String?
    var CreateDate: String?
    var ModifyBy: String?
    var Id: String?
    var ModifyDate: String?
    var Name: String?
    var ParentId: String?
    var CropId: String?
    var Min: Double?
    var Max: Double?
    var DetailText: String?
    var Formula: String?
    var isModify: Bool?
    var Sensor: Bool?
    var StartDate: String?
    
    init(dictionary: [String: AnyObject]) {
        
        self.CreateBy = dictionary["CreateBy"] as? String
        self.CreateDate = dictionary["CreateDate"] as? String
        self.ModifyBy = dictionary["ModifyBy"] as? String
        self.ModifyDate = dictionary["ModifyDate"] as? String
        self.Name = dictionary["Name"] as? String
        self.Id = dictionary["Id"] as? String
        self.ParentId = dictionary["ParentId"] as? String
        self.CropId = dictionary["CropId"] as? String
        self.Formula = dictionary["Formula"] as? String
        self.StartDate = dictionary["StartDate"] as? String
        
        let modify = dictionary["isModify"] as? NSNumber
        let sensor = dictionary["Sensor"] as? NSNumber
        if modify == 1 {
            self.isModify = true
        } else {
            self.isModify = false
        }
        
       
        //print(dictionary["Sensor"] ?? "...")
        
        if sensor == 1 {
            self.Sensor = true
        } else {
            self.Sensor = false
        }
        
        if dictionary["Values"] != nil {
            var values = [Value](), index = 0
            var minVal = Double(), maxVal = Double(), minDate = String(), maxDate = String()
            
            for (key, theValue) in dictionary["Values"] as! [String: AnyObject] {
                var emptyDict: [String: AnyObject] = theValue as! [String : AnyObject]
                emptyDict["Date"] = key as AnyObject?
                emptyDict["Value"] = theValue["Average"] as AnyObject?
                if theValue["Values"] != nil {
                    
                    if let val = emptyDict["Value"], let date = emptyDict["Date"] {
                        let _val = val as! Double
                        let _date = date as! String
                        if index == 0 {
                            minVal = _val
                            minDate = _date
                            maxVal = _val
                            maxDate = _date
                        } else {
                            if minVal > _val {
                                minVal = _val
                                minDate = _date
                            }
                            if maxVal < _val {
                                maxVal = _val
                                maxDate = _date
                            }
                        }
                    }
                        
                    index = index + 1
                    
                    self.Min = minVal
                    self.Max = maxVal
                    self.DetailText = "Minimo \(minDate) = \(minVal), Maximo \(maxDate) = \(maxVal)"
                    
                }
                let value = Value(dictionary: emptyDict)
                values.append(value)
            }
            
            self.Values = values as [Value]?
        }

        
    }
}
