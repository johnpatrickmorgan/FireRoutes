//
//  AlamofireExtensions.swift
//  FireRoutes
//
//  Created by jmorgan on 12/06/2015.
//  Copyright (c) 2015 jmorgan. All rights reserved.
//

import Alamofire

/**
 Extension with convenience methods for easily requesting or stubbing a `Route`.
 */
extension Manager {
    
    /**
     Initiates the route's `URLRequest`, to be serialized by the route's `responseSerializer` into a `Response` which is
     then passed into the completion handler. The type of the `response.result.value` and `response.result.value` are
     inferred according to the route's type. If the route has a non-nil stub property, the stub data will be used instead
     of making the request.
     
     - parameter route:             The route to use for requesting and serializing.
     - parameter completionHandler: The handler to be called on completion of the request.
     */
    public func request<T, U>(route: Route<T, U>, completionHandler:(Response<T, U>) -> Void) {
        
        if let stub = route.stub {
            self.stub(route, stub: stub, completionHandler: completionHandler)
        } else {
            request(route).response(responseSerializer: route, completionHandler: completionHandler)
        }
    }
    
    /**
     Stubs the route's `URLRequest` with data / error from the `RequestStub` after the delay specified by the `RequestStub`.
     The data will be serialized by the route's `responseSerializer` into a `Response` which is
     then passed into the completion handler. The type of the `response.result.value` and `response.result.value` are
     inferred according to the route's type.
     
     - parameter route:             The route to use for stubbing and serializing.
     - parameter stub:              The stub result and delay to use for stubbing and serializing.
     - parameter completionHandler: The handler to be called on completion of the request.
     */
    public func stub<T, U>(route:Route<T, U>, stub: RequestStub, completionHandler:(Response<T, U>) -> Void) {
        
        let request = route.URLRequest
        let data = stub.result.value
        let error = stub.result.error
        let delay = stub.delay
        
        let result = route.serializeResponse(request, nil, data, error)
        let response = Response(request: request, response: nil, data: data, result: result)
        
        if (delay == 0.0) {
            completionHandler(response)
        }
        else {
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(dispatchTime, dispatch_get_main_queue()) { () -> Void in
                completionHandler(response)
            }
        }
    }
}

/**
 Extension with convenience methods for serializing response data.
 */
extension Request {
    
    /**
     Provides a `ResponseSerializer` instance for serializing image data into a UIImage.
     
     - returns: A `ResponseSerializer` instance for serializing image data.
     */
    public static func imageResponseSerializer() -> ResponseSerializer<UIImage, NSError> {

        return ResponseSerializer { request, response, data, error in
            if let data = data, image = UIImage(data: data) {
                return Result.Success(image)
            }
            else {
                let serializationError = Error.errorWithCode(.DataSerializationFailed, failureReason: "Unable to create UIImage from data")
                return Result.Failure(error ?? serializationError)
            }
        }
    }
}
