//
//  RouteExtension.swift
//  FireRoutes
//
//  Created by jmorgan on 12/06/2015.
//  Copyright (c) 2015 jmorgan. All rights reserved.
//

import Alamofire

/**
 Extension with convenience methods for simplifying the creation of `NSMutableURLRequest` instances within a `Route`.
 */
extension Route {
    
    /**
     Convenience method for creating a new URL request.
     
     - parameter method:     The HTTP method for the request; GET by default.
     - parameter url:        The URL for the request
     - parameter parameters: The parameters to be added to the request; nil by default.
     - parameter encoding:   The encoding to use for the parameters; .JSON by default.
     - parameter headers:    The headers to be added to the request; nil by default.
     
     - returns: A NSMutableURLRequest instance.
     */
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
    
    /**
     Convenience method for creating a new GET URL request.
     
     - parameter url:        The URL for the request
     - parameter parameters: The parameters to be added to the request; nil by default.
     - parameter encoding:   The encoding to use for the parameters; .URL by default.
     - parameter headers:    The headers to be added to the request; nil by default.
     
     - returns: A NSMutableURLRequest instance.
     */
    final public func GET(url: URLStringConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = .URL, headers: [String : String]? = nil) -> NSMutableURLRequest {
        
        return request(method: .GET, url: url, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    /**
     Convenience method for creating a new POST URL request.
     
     - parameter url:        The URL for the request
     - parameter parameters: The parameters to be added to the request; nil by default.
     - parameter encoding:   The encoding to use for the parameters; .JSON by default.
     - parameter headers:    The headers to be added to the request; nil by default.
     
     - returns: A NSMutableURLRequest instance.
     */
    final public func POST(url: URLStringConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = .JSON, headers: [String : String]? = nil) -> NSMutableURLRequest {
        
        return request(method: .POST, url: url, parameters: parameters, encoding: encoding, headers: headers)
    }
}
