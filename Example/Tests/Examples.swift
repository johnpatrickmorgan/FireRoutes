//
//  ExampleRoutes.swift
//  Pods
//
//  Created by John Morgan on 08/12/2015.
//
//

@testable import FireRoutes
import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

let baseURL = "http://www.myserver.com/api"

class StringRoute: Route<String,NSError> {
    
    override init() {
        super.init()
        URLRequest = GET(baseURL + "/status")
        responseSerializer = Request.stringResponseSerializer()
    }
}

class JSONRoute: Route<AnyObject,NSError> {

    override init() {
        super.init()
        URLRequest = GET(baseURL + "/example")
        responseSerializer = Request.JSONResponseSerializer()
    }
}

class ImageRoute: Route<UIImage,NSError> {
    
    init(userId: String) {
        super.init()
        URLRequest = GET(baseURL + "/avatar", parameters: ["userid" : userId])
        responseSerializer = Request.imageResponseSerializer()
    }
}

struct MappedModel: Mappable {
    
    var exampleURL: NSURL!
    var exampleString: String!
    var exampleInt: Int!
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        exampleURL       <- (map["Example_URL"], URLTransform())
        exampleString    <- (map["Example_String"])
        exampleInt       <- (map["Example_Int"])
    }
}

class MappedModelRoute: Route<MappedModel,NSError> {
    
    override init() {
        super.init()
        URLRequest = GET(baseURL + "/model")
        responseSerializer = Request.ObjectMapperSerializer(nil)
    }
}
