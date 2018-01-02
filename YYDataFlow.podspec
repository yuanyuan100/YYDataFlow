#
# Be sure to run `pod lib lint YYDataFlow.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YYDataFlow'
  s.version          = '0.0.1'
  s.summary          = '去中心化的KVO，数据驱动'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  对象A的属性a,与数据对象B的属性b绑定，当数据对象B的属性b发生变化时，对象A的属性a可以同步获取改变
                       DESC

  s.homepage         = 'https://github.com/yuanyuan100/YYDataFlow'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yvan' => 'yuanyuan_pyy@163.com' }
  s.source           = { :git => 'https://github.com/yuanyuan100/YYDataFlow.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YYDataFlow/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YYDataFlow' => ['YYDataFlow/Assets/*.png']
  # }
 
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.public_header_files = 'YYDataFlow/Classes/**/NSObject+YYDataFlow.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
