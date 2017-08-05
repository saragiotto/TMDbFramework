Pod::Spec.new do |s|
  s.name             = 'TMDbFramework'
  s.version          = '0.1.0'
  s.summary          = 'Swift framwork to connect with themoviedb.org'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/saragiotto/TMDbFramework'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leonardo Saragiotto' => 'leonardo.saragiotto@gmail.com' }
  s.source           = { :git => 'https://github.com/saragiotto/TMDbFramework.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

  s.source_files = 'TMDbFramework/Classes/**/*'
  

# s.resource_bundles = {
#   'TMDbFramework' => ['TMDbFramework/Assets/*.png']
# }

  s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'ChameleonFramework'

end
