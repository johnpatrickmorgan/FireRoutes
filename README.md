# FireRoutes

[![CI Status](http://img.shields.io/travis/jmorgan/FireRoutes.svg?style=flat)](https://travis-ci.org/jmorgan/FireRoutes)
[![Version](https://img.shields.io/cocoapods/v/FireRoutes.svg?style=flat)](http://cocoapods.org/pods/FireRoutes)
[![License](https://img.shields.io/cocoapods/l/FireRoutes.svg?style=flat)](http://cocoapods.org/pods/FireRoutes)
[![Platform](https://img.shields.io/cocoapods/p/FireRoutes.svg?style=flat)](http://cocoapods.org/pods/FireRoutes)

FireRoutes is a lightweight extension to Alamofire that simplifies API calls.

## Introducing Routes

FireRoutes introduces the concept of a `Route`. A `Route` represents a particular API call - how the request should be structured and how the response data should be interpreted. It does so by conforming to two protocols from Alamofire: `URLRequestConvertible` and `ResponseSerializerType`. 

A `Route` can easily be created like so:

```
class AvatarRoute: Route<UIImage, NSError> {
  
    init(userId: String) {
        super.init()
        URLRequest = "http://www.myserver.com/api/avatar/\(userId)"
        responseSerializer = Request.imageResponseSerializer()
    }
}
```
 
A `Route` succinctly represents all the iOS client's expectations of a particular endpoint.

The `Route` concept also simplifies code at the API call site:

```
	manager.request(AvatarRoute(userID:"jmorgan")) { (response) -> Void in
	
		// compiler infers response.result.value to be of UIImage type
	}
```

## Installation

FireRoutes is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FireRoutes'
```

## Author

jmorgan, johnpatrickmorganuk@gmail.com
Inspired by [Moya](http://github.com/Moya/Moya).

## License

FireRoutes is available under the MIT license. See the LICENSE file for more info.
