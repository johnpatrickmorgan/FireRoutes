Pod::Spec.new do |s|

  s.name             = "FireRoutes"
  s.version          = "0.1.0"
  s.summary          = "A lightweight extension to Alamofire to make ."

  s.description      = <<-DESC
                        FireRoutes is a small extension to Alamofire to make network requests simpler.
                       DESC

  s.homepage         = "https://github.com/johnpatrickmorgan/FireRoutes"
  s.license          = 'MIT'
  s.author           = { "jmorgan" => "johnpatrickmorganuk@gmail.com" }
  s.source           = { :git => "https://github.com/johnpatrickmorgan/FireRoutes.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/Classes/**/*'

  s.dependency 'Alamofire'

end
