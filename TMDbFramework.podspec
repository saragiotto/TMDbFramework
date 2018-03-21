Pod::Spec.new do |s|
  s.name             = 'TMDbFramework'
  s.version          = '1.1.3'
  s.summary          = 'Swift framwork to connect with themoviedb.org'
  s.homepage         = 'https://github.com/saragiotto/TMDbFramework'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leonardo Saragiotto' => 'leonardo.saragiotto@gmail.com' }
  s.source           = { :git => 'https://github.com/saragiotto/TMDbFramework.git', :tag => s.version.to_s }

  s.swift_version = "4.0"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"

  s.source_files = 'TMDbFramework/Classes/**/*'

  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'ChameleonFramework'

end
