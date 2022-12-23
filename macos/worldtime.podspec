#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint worldtime.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'worldtime'
  s.version          = '1.0.1'
  s.summary          = 'World Time Plugin'
  s.description      = <<-DESC
A package to get the world time.
                       DESC
  s.homepage         = 'https://github.com/MiroslavZB/world-time.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'miroslav.z.blagoev@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
