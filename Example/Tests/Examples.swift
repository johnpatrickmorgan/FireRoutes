//
//  ExampleRoutes.swift
//  Pods
//
//  Created by John Morgan on 08/12/2015.
//
//

import FireRoutes
import Foundation
import Alamofire

let baseURL = "http://www.myserver.com/api"

class StringRoute: Route<String> {
    
    override init() {
        super.init()
        request = GET(baseURL + "/status")
        responseSerializer = DataRequest.stringResponseSerializer()
    }
}

class JSONRoute: Route<Any> {

    override init() {
        super.init()
        request = GET(baseURL + "/example")
        responseSerializer = DataRequest.jsonResponseSerializer()
    }
}
