Pod::Spec.new do |s|
    s.name             = 'DGBottomSheet'
    s.version          = '1.0.1'
    s.summary          = 'The lightest swift bottom sheet library'
    s.homepage         = 'https://github.com/donggyushin/DGBottomSheet'
    s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
    s.author           = { 'donggyushin' => 'donggyu9410@gmail.com' }
    s.source           = { :git => 'https://github.com/donggyushin/DGBottomSheet.git', :tag => s.version.to_s }
    s.ios.deployment_target = '12.0'
    s.swift_version = '5.0'
    s.source_files = 'Sources/DGBottomSheet/**/*'
  end
