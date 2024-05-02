//
//  IdealWeightRequestModel.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 29/03/24.
//

import Foundation

struct IdealWeightRequestModel:RequestModelProtocol{

    let gender:String
    let height:String
    
    func getDictionary() -> [String : String] {
        var params:[String:String] = [:]
        params["gender"] = self.gender
        params["height"] = self.height
        return params
    }
}
