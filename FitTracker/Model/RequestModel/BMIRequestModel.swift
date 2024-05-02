//
//  BMIRequestModel.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 28/03/24.
//

import Foundation

struct BMIRequestModel:RequestModelProtocol{

    let age:String
    let weight:String
    let height:String
    
    func getDictionary() -> [String : String] {
        var params:[String:String] = [:]
        params["age"] = self.age
        params["height"] = self.height
        params["weight"] = self.weight
        return params
    }
}
