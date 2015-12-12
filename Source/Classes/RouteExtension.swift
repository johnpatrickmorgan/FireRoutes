//
//  RouteExtension.swift
//  Pods
//
//  Created by John Morgan on 12/12/2015.
//
//

import Alamofire

extension Route {
    
    final public func request(method method: Alamofire.Method = .GET, url: URLStringConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = .URL, headers: [String : String]? = nil) -> NSMutableURLRequest {
        
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url.URLString)!)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let headers = headers {
            for (headerField, headerValue) in headers {
                mutableURLRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        let encodedURLRequest = encoding.encode(mutableURLRequest, parameters: parameters).0
        
        return encodedURLRequest
    }
    
    final public func GET(url: URLStringConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = .URL, headers: [String : String]? = nil) -> NSMutableURLRequest {
        
        return request(method: .GET, url: url, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    final public func POST(url: URLStringConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = .URL, headers: [String : String]? = nil) -> NSMutableURLRequest {
        
        return request(method: .POST, url: url, parameters: parameters, encoding: encoding, headers: headers)
    }
}
