//
//  URLRequestHandler.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 28/03/24.
//

import Foundation

class URLRequestHandler{
    
    static let shared = URLRequestHandler()
    private init(){}
    
    private var arrHeader:[String:String] = {
        var headers = [String:String]()
        headers["X-RapidAPI-Key"] = "33564e72dfmsh2444229e74f8772p132e2bjsnfcf2d6cb0181"
        headers["X-RapidAPI-Host"] = "fitness-calculator.p.rapidapi.com"
        return headers
    }()
    
    func prepareRequest(urlEndPoint:String, params: [String: Any]? = nil) -> URLRequest? {

        var url:URL?
 
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let escapedValue = (value as AnyObject).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                paramString += escapedKey! + "=" + escapedValue! + "&"
            }
            if paramString.last == "&" {
                paramString = String(paramString.dropLast())
            }
            
            let pathWithParams = urlEndPoint + "?" + paramString
            guard let updatedURL = URL.init(string: pathWithParams)
            else { return nil }
            url = updatedURL
        }else{
            url = URL.init(string: urlEndPoint)
        }
        guard let url = url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.allHTTPHeaderFields = arrHeader
        urlRequest.timeoutInterval = 10
        
        return urlRequest
    }
    
    
}
