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
     - parameter encoding:   The encoding to use for the parameters; `URLEncoding` by default.
     - parameter headers:    The headers to be added to the request; nil by default.
     
     - returns: A URLRequest instance.
     */
    final public func request(_ method: Alamofire.HTTPMethod = .get, _ url: URLConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = URLEncoding(), headers: HTTPHeaders? = nil) -> URLRequest? {

        do {
            let urlRequest = try URLRequest(url: url, method: method, headers: headers)
            return try encoding.encode(urlRequest, with: parameters)
        } catch {
            return nil
        }
    }
    
    /**
     Convenience method for creating a new GET URL request.
     
     - parameter url:        The URL for the request
     - parameter parameters: The parameters to be added to the request; nil by default.
     - parameter encoding:   The encoding to use for the parameters; .URL by default.
     - parameter headers:    The headers to be added to the request; nil by default.
     
     - returns: A URLRequest instance.
     */
    final public func GET(_ url: URLConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = URLEncoding(), headers: HTTPHeaders? = nil) -> URLRequest? {
        
        return request(.get, url, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    /**
     Convenience method for creating a new POST URL request.
     
     - parameter url:        The URL for the request
     - parameter parameters: The parameters to be added to the request; nil by default.
     - parameter encoding:   The encoding to use for the parameters; .JSON by default.
     - parameter headers:    The headers to be added to the request; nil by default.
     
     - returns: A URLRequest instance.
     */
    final public func POST(_ url: URLConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = JSONEncoding(), headers: HTTPHeaders? = nil) -> URLRequest? {
        
        return request(.post, url, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    /**
     Convenience method for creating a new PUT URL request.
     
     - parameter url:        The URL for the request
     - parameter parameters: The parameters to be added to the request; nil by default.
     - parameter encoding:   The encoding to use for the parameters; .JSON by default.
     - parameter headers:    The headers to be added to the request; nil by default.
     
     - returns: A URLRequest instance.
     */
    final public func PUT(_ url: URLConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = JSONEncoding(), headers: HTTPHeaders? = nil) -> URLRequest? {
        
        return request(.put, url, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    /**
     Convenience method for creating a new DELETE URL request.
     
     - parameter url:        The URL for the request
     - parameter parameters: The parameters to be added to the request; nil by default.
     - parameter encoding:   The encoding to use for the parameters; .JSON by default.
     - parameter headers:    The headers to be added to the request; nil by default.
     
     - returns: A URLRequest instance.
     */
    final public func DELETE(_ url: URLConvertible, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding = JSONEncoding(), headers: HTTPHeaders? = nil) -> URLRequest? {
        
        return request(.delete, url, parameters: parameters, encoding: encoding, headers: headers)
    }
}
