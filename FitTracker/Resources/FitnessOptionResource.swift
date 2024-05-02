//
//  FitnessOptionResource.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 28/03/24.
//

import Foundation

protocol FitnessOptionProtocol{

    func genericFetchData<requestModel:RequestModelProtocol,responseModel:Codable>(for endPoint:String, requestModel:requestModel,_ completion: @escaping( (responseModel?, ApiError?) -> () ))
}

class FitnessOptionResource : FitnessOptionProtocol{
    
    func genericFetchData<requestModel:RequestModelProtocol,responseModel:Codable>(for endPoint:String, requestModel:requestModel,_ completion: @escaping( (responseModel?, ApiError?) -> () )){
        
        let params = requestModel.getDictionary()
        
        HttpHandler.shared.createDataTask(for: endPoint, with: params, resultType: responseModel.self) { (result:Result<responseModel, ApiError>) in
            
            switch result {
            case .success(let model):
                completion(model,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
}
