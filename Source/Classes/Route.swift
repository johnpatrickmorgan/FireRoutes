//
//  Route.swift
//  FireRoutes
//
//  Created by jmorgan on 12/06/2015.
//  Copyright (c) 2015 jmorgan. All rights reserved.
//

import Alamofire

public enum FireRouteError: Error {
    
    case routeNotSubclassed
    case routeMissingRequest
}

/**
 Abstract superclass for encapsulating instructions for a single endpoint - how the URL request should be formed and how
 the response should be serialized.
 */
open class Route<U>: URLRequestConvertible, DataResponseSerializerProtocol {

    public typealias SerializedObject = U

    /**
     The URLRequest for this route - ensures conformance to `URLRequestConvertible` protocol.
     */
    public func asURLRequest() throws -> URLRequest {
        
        guard let request = request else { throw FireRouteError.routeMissingRequest }
        return try request.asURLRequest()
    }
    
    /**
     The `ResponseSerializer` for this route - The `Route` superclass's implementation of `ResponseSerializerType` simply delegates
     response serialization to this `ResponseSerializer`. Concrete subclasses can set this property to any ResponseSerializer, such
     as those included in Alamofire.
     */
    public var responseSerializer: DataResponseSerializer<U> = DataResponseSerializer { _,_,_,_ in
        
        return Result.failure(FireRouteError.routeNotSubclassed)
    }
    
    /// TODO
    public var request: URLRequestConvertible?
    
    /**
     There should be no need to customize this behaviour - it simply delegates response serialization to the `ResponseSerializer`.
     */
    final public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<U> {
        
        return responseSerializer.serializeResponse
    }
    
    /**
     Empty initializer to appease the compiler in some circumstances.
     */
    public init() { }
}

/**
 A specific type of `Result` that encapsulates the information returned by a URL request. Used to stub URL requests with dummy data / errors.
 */
public typealias RequestResult = Result<Data>

/**
 A tuple that encapsulates the information required to stub URL requests with dummy data / errors.
 
 - parameter result:     The RequestResult to be returned by the stubbed request.
 - parameter delay:      The delay after which to return the stubbed data.
 */
public typealias RequestStub = (result: RequestResult, delay: TimeInterval)
