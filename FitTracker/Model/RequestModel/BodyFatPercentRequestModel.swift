import Foundation

protocol RequestModelProtocol{
    func getDictionary() -> [String:String]
}

struct BodyFatPercentRequestModel:RequestModelProtocol{
    
    let age:String
    let gender:String
    let weight:String
    let height:String
    let neck:String
    let waist:String
    let hip:String
    
    func getDictionary() -> [String:String]{
        var params:[String:String] = [:]
        params["age"] = self.age
        params["gender"] = self.gender
        params["height"] = self.height
        params["weight"] = self.weight
        params["neck"] = self.neck
        params["waist"] = self.waist
        params["hip"] = self.hip
        return params
    }
}
