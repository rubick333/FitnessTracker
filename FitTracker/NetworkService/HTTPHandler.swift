//
//  HTTPHandler.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 28/03/24.
//

import Foundation

enum ApiError : Error{
    
    case INTERNET_ERROR
    case API_ENDPOINT_ERROR
    case DECODE_ERROR
    case SERVER_RESPONSE_ERROR
    case DATA_FETCH_ERROR
    
    var localizedDescription : String {
        switch self {
        case .INTERNET_ERROR:
            return "Please check your Network Connection."
        
        case .API_ENDPOINT_ERROR:
            return "something went wrong"
            
        case .DECODE_ERROR:
            return "Something went wrong"
            
        case .SERVER_RESPONSE_ERROR:
            return "Failed to update your status. Please contact us."
            
        case .DATA_FETCH_ERROR:
            return "Unable to fetch details, please try later."
        }
    }
}

class HttpHandler{
    
    static let shared = HttpHandler()
    private init(){}
    
    typealias ResponseClosure<T:Codable> = (Result<T, ApiError>) -> Void
    
    func createDataTask<T:Codable>(for urlEndPoint:String,with params: [String: Any]? = nil,resultType: T.Type,completion:@escaping(ResponseClosure<T>)){
        
        if InternetHandler.shared.checkForInternetConnection() == false {
            completion(.failure(.INTERNET_ERROR))
            return
        }
        
        guard let urlRequest = URLRequestHandler.shared.prepareRequest(urlEndPoint: urlEndPoint,params: params)
        else{
            completion(.failure(.API_ENDPOINT_ERROR))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error {
                completion(.failure(.SERVER_RESPONSE_ERROR))
            }
            
            if let data {
                let jsonDecoder = JSONDecoder.init()
                do {
                    //print(String(data: data, encoding: .utf8) ?? "")
                    let model = try jsonDecoder.decode(resultType, from: data)
                    completion(.success(model))
                    
                }catch let DecodingError.dataCorrupted(context) {
                    //print(context)
                    completion(.failure(.DECODE_ERROR))
                } catch let DecodingError.keyNotFound(key, context) {
                    //print("Key '\(key)' not found:", context.debugDescription)
                    //print("codingPath:", context.codingPath)
                    completion(.failure(.DECODE_ERROR))
                } catch let DecodingError.valueNotFound(value, context) {
                    //print("Value '\(value)' not found:", context.debugDescription)
                    //print("codingPath:", context.codingPath)
                    completion(.failure(.DECODE_ERROR))
                } catch let DecodingError.typeMismatch(type, context)  {
                    //print("Type '\(type)' mismatch:", context.debugDescription)
                    //print("codingPath:", context.codingPath)
                    completion(.failure(.DECODE_ERROR))
                } catch {
                    //print("error: ", error)
                    completion(.failure(.DECODE_ERROR))
                }
            }
        }.resume()
    }
    
    
}
