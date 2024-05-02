//
//  DailyCaloryRequirementRequestModel.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 30/03/24.
//

import Foundation

struct DailyCaloryRequirementRequestModel:RequestModelProtocol{
    
    let age:String
    let gender:String
    let weight:String
    let height:String
    let activityLevel:String
    
    func getDictionary() -> [String:String]{
        var params:[String:String] = [:]
        params["age"] = self.age
        params["gender"] = self.gender
        params["height"] = self.height
        params["weight"] = self.weight
        params["activitylevel"] = self.activityLevel
        return params
    }
}
