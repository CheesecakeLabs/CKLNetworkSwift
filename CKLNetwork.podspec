Pod::Spec.new do |s|
  s.name             = 'CKLNetwork'
  s.version          = '0.0.4'
  s.summary          = 'Wrapping library to maintain standard requests. Design patter MVVM'
 

  s.description      = <<-DESC
  It is a wrapping library for requests, you can change the base of requests to the API of your choice. We are currently using Alamofire. Design patter MVVM
                       DESC

  s.homepage         = 'https://github.com/CheesecakeLabs/CKLNetworkSwift' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cherobin' => 'ricardo@cherobin.com.br' }
  s.source           = { :git => 'https://github.com/CheesecakeLabs/CKLNetworkSwift.git', :tag => '0.0.4' }
  s.social_media_url = 'https://twitter.com/RicCherobin'

  s.ios.deployment_target = '12.0'
  s.platform = :ios, '12.0'
  
  s.source_files = 'CKLNetworkLibrary/Classes/**/*'  
  s.dependency 'Alamofire', '~> 5.2.1'  
  s.swift_version = '5'
end
