# FireRoutes ![FIREROUTES](http://s30.postimg.org/hbdbjf5wh/Fire_Routes_SMALL.png) 

[![CI Status](http://img.shields.io/travis/jmorgan/FireRoutes.svg?style=flat)](https://travis-ci.org/jmorgan/FireRoutes)
[![Version](https://img.shields.io/cocoapods/v/FireRoutes.svg?style=flat)](http://cocoapods.org/pods/FireRoutes)
[![License](https://img.shields.io/cocoapods/l/FireRoutes.svg?style=flat)](http://cocoapods.org/pods/FireRoutes)
[![Platform](https://img.shields.io/cocoapods/p/FireRoutes.svg?style=flat)](http://cocoapods.org/pods/FireRoutes)

FireRoutes is a lightweight extension to [Alamofire](https://github.com/Alamofire/Alamofire) that simplifies network calls through the concept of a `Route`.

## What is a Route?

A `Route` represents how a particular network call should be structured and how the response data should be transformed into a useable object. It conforms to two protocols from Alamofire: `URLRequestConvertible` and `ResponseSerializerType`. 

A `Route` subclass can be defined like so:

```
let baseURL = "http://www.myserver.com/api"

class AvatarRoute: Route<UIImage, NSError> {
  
    init(userId: String) {
        super.init()
        URLRequest = GET(baseURL + "/avatar/\(userId)_img.png")
        responseSerializer = Request.imageResponseSerializer()
    }
}
```

This captures in a single class all of the client's expectations of the avatar endpoint. Defining a number of routes in a single `Routes.swift` file provides a useful catalogue of all the endpoints your app may use.


The `Route` concept also simplifies the code that originates the request:

```
manager.request(AvatarRoute(userID:"jmorgan")) { response in

	// compiler infers response.result.value to be of UIImage type
}
```

The compiler infers the correct `Result` type, keeping your code clean and simple.

## Unit Testing

Unit tests should not be dependent on network responses. Routes have built-in support for easily stubbing requests with dummy data / errors, so that you can test your other code independently:

```
	if let url = NSBundle(forClass: Tests.self).URLForResource("TestAvatar", withExtension: "png") {
		let data = NSData(contentsOfURL: url)
		route.stub = (RequestResult.Success(data), delay: 0.1)
	}
```
This can also be very useful during development, when you don't want to be held back by an unreliable network connection.

## Custom Response Serialization

Despite its simple approach, FireRoutes retains all the flexibility of `NSMutableURLRequest` and `ResponseSerializerType`. You can use it in conjunction with other Alamofire extensions such as [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper) to generate custom model objects...

```
class MappedModelRoute: Route<MappedModel, NSError> {
    
    override init() {
        super.init()
        URLRequest = GET(baseURL + "/model")
        responseSerializer = Request.ObjectMapperSerializer(nil)
    }
}
```
...which means the response will be parsed and mapped into your custom model object:

```
manager.request(MappedModelRoute()) { response in
	
	// compiler infers response.result.value to be of MappedModel type
}
```

## Installation

FireRoutes is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FireRoutes'
```

## Author

johnpatrickmorgan, johnpatrickmorganuk@gmail.com.

Partly inspired by [Moya](http://github.com/Moya/Moya).

## License

FireRoutes is available under the MIT license. See the LICENSE file for more info.
