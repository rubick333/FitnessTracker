import Foundation

class IdealWeightResponseModel:Codable{
    
    let statusCode:Int
    let result:String
    let idealWeightData:IdealWeightData
    
    enum ApiParsingKeys : String, CodingKey{
        case idealWeightData = "data"
        case statusCode = "status_code"
        case result = "request_result"
    }
    
    required init(from decoder:Decoder) throws {
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        statusCode = try value.decode(Int.self, forKey: .statusCode)
        result = try value.decode(String.self, forKey: .result)
        idealWeightData = try value.decode(IdealWeightData.self, forKey: .idealWeightData)
    }
}

class IdealWeightData:Codable{
    
    let hamwi:Float
    let devine:Float
    let miller:Float
    let robinson:Float
    
    enum ApiParsingKeys : String, CodingKey{
        case hamwi = "Hamwi"
        case devine = "Devine"
        case miller = "Miller"
        case robinson = "Robinson"
    }
    
    required init(from decoder:Decoder) throws {
        let value = try decoder.container(keyedBy: ApiParsingKeys.self)
        hamwi = try value.decode(Float.self, forKey: .hamwi)
        devine = try value.decode(Float.self, forKey: .devine)
        miller = try value.decode(Float.self, forKey: .miller)
        robinson = try value.decode(Float.self, forKey: .robinson)
    }
}
