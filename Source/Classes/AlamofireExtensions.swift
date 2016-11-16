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
extension SessionManager {
    
    /**
     Initiates the route's `URLRequest`, to be serialized by the route's `responseSerializer` into a `Response` which is
     then passed into the completion handler. The type of the `response.result.value` and `response.result.value` are
     inferred according to the route's type.
     
     - parameter route:             The route to use for requesting and serializing.
     - parameter completionHandler: The handler to be called on completion of the request.
     */
    @discardableResult public func request<T>(_ route: Route<T>, completionHandler: @escaping (DataResponse<T>) -> Void) -> Request {
        
        return request(route).response(responseSerializer: route, completionHandler: completionHandler) // onse(responseSerializer: route, completionHandler: completionHandler)
    }
    

    /**
     Stubs the route's `URLRequest` with data / error from the `RequestStub` after the delay specified by the `RequestStub`.
     The data will be serialized by the route's `responseSerializer` into a `Response` which is
     then passed into the completion handler. The type of the `response.result.value` and `response.result.value` are
     inferred according to the route's type.
     
     - parameter route:             The route to use for stubbing and serializing.
     - parameter stub:              The stub result and delay to use for stubbing and serializing.
     - parameter route:             The route to use for requesting and serializing.
     - parameter completionHandler: The handler to be called on completion of the request.
     */
    public func stub<T>(_ route: Route<T>, stub: RequestStub, completionHandler: @escaping (DataResponse<T>) -> Void) {
        
        do {
            let request = try route.asURLRequest()
            let data = stub.result.value
            let error = stub.result.error
            let delay = stub.delay
            
            let result = route.serializeResponse(request, nil, data, error)
            let response = DataResponse(request: request, response: nil, data: data, result: result)
            
            if (delay == 0.0) {
                completionHandler(response)
            }
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    completionHandler(response)
                }
            }
        } catch {
            let result: Result<T> = Result.failure(FireRouteError.routeMissingRequest)
            let response = DataResponse(request: nil, response: nil, data: nil, result: result)
            completionHandler(response)
        }

    }
}
