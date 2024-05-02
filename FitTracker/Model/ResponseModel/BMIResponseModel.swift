//
//  BMIResponseModel.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 28/03/24.
//

import Foundation

class BMIResponseModel:Codable{
    
    let statusCode:Int
    let result:String
    let bmiData:BMIData
    
    enum ApiParsingKeys : String, CodingKey{
        case bmiData = "data"
        case statusCode = "status_code"
        case result = "request_result"
    }
    
    required init(from decoder:Decoder) throws {
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        statusCode = try value.decode(Int.self, forKey: .statusCode)
        result = try value.decode(String.self, forKey: .result)
        bmiData = try value.decode(BMIData.self, forKey: .bmiData)
    }
}

class BMIData:Codable{
    
    let bmi:Float
    let health:String
    let healthyBMIRange:String
    
    enum ApiParsingKeys : String, CodingKey{
        case bmi,health
        case healthyBMIRange = "healthy_bmi_range"
    }
    
    required init(from decoder:Decoder) throws {
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        bmi = try value.decode(Float.self, forKey: .bmi)
        health = try value.decode(String.self, forKey: .health)
        healthyBMIRange = try value.decode(String.self, forKey: .healthyBMIRange)
    }
}
