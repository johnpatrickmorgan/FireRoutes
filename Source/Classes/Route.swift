//
//  Route.swift
//  FireRoutes
//
//  Created by jmorgan on 12/06/2015.
//  Copyright (c) 2015 jmorgan. All rights reserved.
//

import Alamofire

public class Route<U, V: ErrorType>: URLRequestConvertible, ResponseSerializerType {

    public typealias SerializedObject = U
    public typealias ErrorObject = V

    public var URLRequest = NSMutableURLRequest(URL: NSURL(string: "")!)
    
    public var responseSerializer: ResponseSerializer<U, V> = ResponseSerializer { _,_,_,_ in
        let failureReason = "Route subclasses must specify a valid responseSerializer property"
        let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
        return Result.Failure(error as! V)
    }
    
    final public var serializeResponse: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Result<U, V> {
        return responseSerializer.serializeResponse
    }
    
    public var stub: RequestStub? = nil
    
    public init() {
        
    }
}

public typealias RequestResult = Result<NSData, NSError>

public typealias RequestStub = (result: RequestResult, delay: NSTimeInterval)
