#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint worldtime.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'worldtime'
  s.version          = '1.0.1'
  s.summary          = 'World Time Plugin'
  s.description      = <<-DESC
Package to get the World time by location or TZ time zone.
                       DESC
  s.homepage         = 'https://github.com/MiroslavZB/world-time.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'miroslav.z.blagoev@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
