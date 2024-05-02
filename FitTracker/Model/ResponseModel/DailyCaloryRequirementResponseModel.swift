//
//  DailyCaloryRequirementResponseModel.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 30/03/24.
//

import Foundation

class DailyCaloryRequirementResponseModel:Codable{
    
    let statusCode:Int
    let result:String
    let dailyCaloryRequirementData:DailyCaloryRequirementData
    
    enum ApiParsingKeys : String, CodingKey{
        case dailyCaloryRequirementData = "data"
        case statusCode = "status_code"
        case result = "request_result"
    }
    
    required init(from decoder:Decoder) throws {
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        
        statusCode = try value.decode(Int.self, forKey: .statusCode)
        result = try value.decode(String.self, forKey: .result)
        dailyCaloryRequirementData = try value.decode(DailyCaloryRequirementData.self, forKey: .dailyCaloryRequirementData)
    }
}

class DailyCaloryRequirementData:Codable{
    let BMR:Float
    let goals:CaloryGoalsData
}

class CaloryGoalsData:Codable{
    let maintainWeight:Float
    let mildWeightLoss:WeightLossData
    let normalWeightLoss:WeightLossData
    let extremeWeightLoss:WeightLossData
    let mildWeightGain:WeightGainData
    let normalWeightGain:WeightGainData
    let extremeWeightGain:WeightGainData
    
    enum ApiParsingKeys : String, CodingKey{
        case maintainWeight = "maintain weight"
        case mildWeightLoss = "Mild weight loss"
        case normalWeightLoss = "Weight loss"
        case extremeWeightLoss = "Extreme weight loss"
        case mildWeightGain = "Mild weight gain"
        case normalWeightGain = "Weight gain"
        case extremeWeightGain = "Extreme weight gain"
    }
    
    required init(from decoder:Decoder) throws {
        
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        
        maintainWeight = try value.decode(Float.self, forKey: .maintainWeight)
        mildWeightLoss = try value.decode(WeightLossData.self, forKey: .mildWeightLoss)
        normalWeightLoss = try value.decode(WeightLossData.self, forKey: .normalWeightLoss)
        extremeWeightLoss = try value.decode(WeightLossData.self, forKey: .extremeWeightLoss)
        mildWeightGain = try value.decode(WeightGainData.self, forKey: .mildWeightGain)
        normalWeightGain = try value.decode(WeightGainData.self, forKey: .normalWeightGain)
        extremeWeightGain = try value.decode(WeightGainData.self, forKey: .extremeWeightGain)
    }
}

class WeightLossData:Codable{
    let lossWeight:String
    let calory:Float
    
    enum ApiParsingKeys : String, CodingKey{
        case lossWeight = "loss weight"
        case calory
    }
    
    required init(from decoder:Decoder) throws {
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        
        lossWeight = try value.decode(String.self, forKey: .lossWeight)
        calory = try value.decode(Float.self, forKey: .calory)
    }
}

class WeightGainData:Codable{
    let gainWeight:String
    let calory:Float
    
    enum ApiParsingKeys : String, CodingKey{
        case gainWeight = "gain weight"
        case calory
    }
    
    required init(from decoder:Decoder) throws {
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        
        gainWeight = try value.decode(String.self, forKey: .gainWeight)
        calory = try value.decode(Float.self, forKey: .calory)
    }
}


