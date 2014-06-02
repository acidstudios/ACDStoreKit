#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "ACDStoreKit"
  s.version          = "0.0.1"
  s.summary          = "Acid Studios Store Kit Implementation."
  s.homepage         = "http://www.acidstudios.me"
  s.license          = 'MIT'
  s.author           = { "Gustavo Barrientos Guerrero" => "gustavo.barrientos@acidstudios.mx" }
  s.source           = { :git => "https://github.com/acidstudios/ACDStoreKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/acidstudios'

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  #s.osx.deployment_target = '10.8'
  s.requires_arc = true

  s.source_files = 'Classes'

  s.frameworks = 'StoreKit'

end
