//
//  ExampleRoutes.swift
//  Pods
//
//  Created by John Morgan on 08/12/2015.
//
//

import FireRoutes
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

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

class ImageRoute: Route<UIImage> {
    
    init(userId: String) {
        super.init()
        request = GET(baseURL + "/avatar", parameters: ["userid" : userId])
        responseSerializer = DataRequest.imageResponseSerializer()
    }
}

struct MappedModel: Mappable {
    
    var exampleURL: URL!
    var exampleString: String!
    var exampleInt: Int!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        exampleURL       <- (map["Example_URL"], URLTransform())
        exampleString    <- (map["Example_String"])
        exampleInt       <- (map["Example_Int"])
    }
}

class MappedModelRoute: Route<MappedModel> {
    
    override init() {
        super.init()
        request = GET(baseURL + "/model")
        responseSerializer = DataRequest.ObjectMapperSerializer(nil)
    }
}
