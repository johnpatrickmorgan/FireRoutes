# 🔥 FireRoutes 🔥

[![Version](https://img.shields.io/cocoapods/v/FireRoutes.svg?style=flat)](http://cocoapods.org/pods/FireRoutes)
[![License](https://img.shields.io/cocoapods/l/FireRoutes.svg?style=flat)](http://cocoapods.org/pods/FireRoutes)
![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)

FireRoutes is a lightweight extension to [Alamofire](https://github.com/Alamofire/Alamofire) that simplifies network calls through the concept of a `Route`.

## What is a Route?

A `Route` represents how a particular network call should be structured and how the response data should be transformed into a useable object. It conforms to two protocols from Alamofire: `URLRequestConvertible` and `DataResponseSerializerProtocol`. 

A `Route` subclass can be defined like so:

```swift
let baseURL = "http://www.myserver.com/api"

class AvatarRoute: Route<UIImage> {
  
    init(userId: String) {
        super.init()
        request = GET(baseURL + "/avatar/\(userId)_img.png")
        responseSerializer = DataRequest.imageResponseSerializer()
    }
}
```

This captures in a single class all of the client's expectations of the avatar endpoint. Defining a number of routes in a single `Routes.swift` file provides a useful catalogue of all the endpoints your app may use.


The `Route` concept also simplifies the code that originates the request via an extension to Alamofire's `SessionManager`:

```swift
manager.request(AvatarRoute(userID:"jmorgan")) { response in

	// compiler infers response.result.value to be of UIImage type
}
```

The compiler infers the correct `Result` type, keeping your code clean and simple.

## Custom Response Serialization

Despite its simple approach, FireRoutes retains all the flexibility of `URLRequestConvertible` and `DataResponseSerializerProtocol`. You can use it in conjunction with other Alamofire extensions such as [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper) to generate custom model objects...

```swift
class MappedModelRoute: Route<MappedModel> {
    
    override init() {
        super.init()
        request = GET(baseURL + "/model")
        responseSerializer = DataRequest.ObjectMapperSerializer(nil)
    }
}
```
...which means the response will be parsed and mapped into your custom model object:

```swift
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

## License

FireRoutes is available under the MIT license. See the LICENSE file for more info.
