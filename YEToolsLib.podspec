#
# Be sure to run `pod lib lint YEToolsLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YEToolsLib'
  s.version          = '0.1.3'
  s.summary          = 'A short description of YEToolsLib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    YoueData IOS Developer base lib
                       DESC

  s.homepage         = 'https://github.com/WriteforBlack/YEToolsLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WriteforBlack' => 'kunpenghong@gmail.com' }
  s.source           = { :git => 'https://github.com/WriteforBlack/YEToolsLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YEToolsLib/Classes/*'
  s.public_header_files = 'YEToolsLib/Classes/*.h'

  s.subspec 'Base' do |ss|
    ss.source_files = 'YEToolsLib/Classes/Base/**/*'
    ss.public_header_files = 'YEToolsLib/Classes/Base/**/*.h'
  end

  s.subspec 'Extensions' do |ss|
    ss.source_files = 'YEToolsLib/Classes/Extensions/**/*'
    ss.public_header_files = 'YEToolsLib/Classes/Extensions/**/*.h'
  end

  s.subspec 'Vendor' do |ss|
    ss.source_files = 'YEToolsLib/Classes/Vendor/**/*'
    ss.public_header_files = 'YEToolsLib/Classes/Vendor/**/*.h'
  end

  s.frameworks = 'Foundation', 'StoreKit','UIKit'
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'SDWebImage', '~> 4.0.0'
  s.dependency 'MJRefresh', '~> 3.1.12'
  s.dependency 'SVProgressHUD', '~> 2.1.2'
  s.dependency 'MJExtension', '~> 3.0.13'
  s.dependency 'EGOCache', '~> 2.1.3'

  # s.resource_bundles = {
  #   'YEToolsLib' => ['YEToolsLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
