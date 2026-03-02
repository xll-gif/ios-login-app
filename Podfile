# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'ios-login-app' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ios-login-app
  # Add any third-party dependencies here, for example:
  # pod 'Alamofire', '~> 5.0'
  # pod 'Kingfisher', '~> 7.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
