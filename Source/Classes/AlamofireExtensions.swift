//
//  ManagerExtension.swift
//  Pods
//
//  Created by John Morgan on 12/12/2015.
//
//

import Alamofire

extension Manager {
    
    public func request<T, U>(route: Route<T, U>, completionHandler:(Response<T, U>) -> Void) {
        
        if let stub = route.stub {
            self.stub(route, stub: stub, completionHandler: completionHandler)
        } else {
            request(route).response(responseSerializer: route, completionHandler: completionHandler)
        }
    }
    
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

extension Request {
    
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
