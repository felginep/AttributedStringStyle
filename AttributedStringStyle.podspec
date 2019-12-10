#
# Be sure to run `pod lib lint AttributedStringStyle.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AttributedStringStyle'
  s.version          = '1.0.1'
  s.summary          = 'Focus on the semantic and the visual representation of NSAttributedString separately.'
  s.homepage         = 'https://github.com/felginep/AttributedStringStyle'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Pierre Felgines'
  s.social_media_url = 'http://twitter.com/PierreFelgines'
  s.source           = { :git => 'https://github.com/felginep/AttributedStringStyle.git', :tag => "v#{s.version}" }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/**/*'
  s.framework    = 'Foundation'
  s.swift_versions = '5.0'
end
