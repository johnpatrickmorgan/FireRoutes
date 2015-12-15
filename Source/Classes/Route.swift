//
//  Route.swift
//  FireRoutes
//
//  Created by jmorgan on 12/06/2015.
//  Copyright (c) 2015 jmorgan. All rights reserved.
//

import Alamofire

/**
 Abstract superclass for encapsulating instructions for a single endpoint - how the URL request should be formed and how
 the response should be serialized.
 */
public class Route<U, V: ErrorType>: URLRequestConvertible, ResponseSerializerType {

    public typealias SerializedObject = U
    public typealias ErrorObject = V

    /**
     The URLRequest for this route - ensures conformance to `URLRequestConvertible` protocol.
     */
    public var URLRequest = NSMutableURLRequest(URL: NSURL(string: "")!)
    
    /**
     The `ResponseSerializer` for this route - The `Route` superclass's implementation of `ResponseSerializerType` simply delegates
     response serialization to this `ResponseSerializer`. Concrete subclasses can set this property to any ResponseSerializer, such
     as those included in Alamofire.
     */
    public var responseSerializer: ResponseSerializer<U, V> = ResponseSerializer { _,_,_,_ in
        
        let failureReason = "Route subclasses must specify a valid responseSerializer property"
        let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
        return Result.Failure(error as! V)
    }
    
    /**
     There should be no need to customize this behaviour - it simply delegates response serialization to the `ResponseSerializer`.
     */
    final public var serializeResponse: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Result<U, V> {
        
        return responseSerializer.serializeResponse
    }
    
    /**
     If this property is nil, as it is by default, no stubbing will take place. Setting this property to a `RequestStub` will ensure
     that the `Manager` requesting the route will use the stub data instead of making the URL request.
     */
    public var stub: RequestStub? = nil
    
    /**
     Empty initializer to appease the compiler in some circumstances.
     */
    public init() {
        
    }
}

/**
 A specific type of `Result` that encapsulates the information returned by a URL request. Used to stub URL requests with dummy data / errors.
 */
public typealias RequestResult = Result<NSData, NSError>

/**
 A tuple that encapsulates the information required to stub URL requests with dummy data / errors.
 
 - parameter result:     The RequestResult to be returned by the stubbed request.
 - parameter delay:      The delay after which to return the stubbed data.
 */
public typealias RequestStub = (result: RequestResult, delay: NSTimeInterval)
