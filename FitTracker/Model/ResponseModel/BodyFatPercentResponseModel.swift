//
//  BodyFatPercentResponseModel.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 28/03/24.
//

import Foundation

class BodyFatPercentResponseModel:Codable{
    
    let statusCode:Int
    let result:String
    let bodyFatPercentData:BodyFatPercentData
    
    enum ApiParsingKeys : String, CodingKey{
        case bodyFatPercentData = "data"
        case statusCode = "status_code"
        case result = "request_result"
    }
    
    required init(from decoder:Decoder) throws {
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        statusCode = try value.decode(Int.self, forKey: .statusCode)
        result = try value.decode(String.self, forKey: .result)
        bodyFatPercentData = try value.decode(BodyFatPercentData.self, forKey: .bodyFatPercentData)
    }
}

class BodyFatPercentData:Codable{
    
    let bodyFatPercentUSNavyMethod:Float
    let bodyFatPercentBMIMethod:Float
    let bodyFatCategory:String
    let bodyFatMass:Float
    let leanBodyMass:Float
    
    enum ApiParsingKeys : String, CodingKey{
        case bodyFatPercentUSNavyMethod = "Body Fat (U.S. Navy Method)"
        case bodyFatPercentBMIMethod = "Body Fat (BMI method)"
        case bodyFatCategory = "Body Fat Category"
        case bodyFatMass = "Body Fat Mass"
        case leanBodyMass = "Lean Body Mass"
    }
    
    required init(from decoder:Decoder) throws {
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        bodyFatPercentUSNavyMethod = try value.decode(Float.self, forKey: .bodyFatPercentUSNavyMethod)
        bodyFatPercentBMIMethod = try value.decode(Float.self, forKey: .bodyFatPercentBMIMethod)
        bodyFatCategory = try value.decode(String.self, forKey: .bodyFatCategory)
        bodyFatMass = try value.decode(Float.self, forKey: .bodyFatMass)
        leanBodyMass = try value.decode(Float.self, forKey: .leanBodyMass)
    }
}
