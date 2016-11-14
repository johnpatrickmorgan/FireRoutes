Pod::Spec.new do |s|

  s.name             = "FireRoutes"
  s.version          = "0.1.1"
  s.summary          = "A lightweight extension to Alamofire to simplify API calls."

  s.description      = <<-DESC
                        FireRoutes introduces the concept of a Route. A Route represents a particular API call - how the request should be structured and how the response data should be interpreted. 
                       DESC

  s.homepage         = "https://github.com/johnpatrickmorgan/FireRoutes"
  s.license          = 'MIT'
  s.author           = { "jmorgan" => "johnpatrickmorganuk@gmail.com" }
  s.source           = { :git => "https://github.com/johnpatrickmorgan/FireRoutes.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/**/*'

  s.dependency 'Alamofire', '~> 3.5'

end
