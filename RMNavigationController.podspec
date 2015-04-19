Pod::Spec.new do |s|
  s.name         = "RMNavigationController"
  s.version      = "0.1"
  s.summary      = "Navigation controller to handle navigationbar hiding"
  s.description  = "Navigation controller to handle navigationbar hiding and an example to achieve transparent navigation bar with an image like in the Twitter app"
  s.homepage     = "https://github.com/intonarumori/RMNavigationController"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { "Daniel Langh" => "intonarumori@gmail.com" }
  s.source       = { :git => "https://github.com/intonarumori/RMNavigationController", :tag => "v0.1" }
  s.platform     = :ios, '7.0'

  s.source_files = 'RMNavigationController/*.{h,m}'
  s.requires_arc = true
  s.frameworks   = [ "UIKit" ]
end