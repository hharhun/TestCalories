inhibit_all_warnings!
use_frameworks!

platform :ios, '15.0'

def external_pods 
  use_frameworks!

  # Formatter
  pod 'SwiftLint', '0.55.1'
  pod 'SwiftFormat/CLI', '0.54.1'

  # Initialization
  pod 'Then', '3.0.0'
   
  # Keyboard
  pod 'Typist', '1.4.2'

  # Sequre storage
  pod 'KeychainAccess', '4.2.2'

  # Constraints
  pod 'SnapKit', '5.7.1'
  
  # Loader
  pod 'NVActivityIndicatorView', '5.1.1'
  
  # Requests
  pod 'Moya', '15.0.0'
end

def feature_pods
  pod "Core", :path => "./Modules/Core"
  pod "Models", :path => "./Modules/Models"
  pod "Resources", :path => "./Modules/Resources"
  pod "Extensions", :path => "./Modules/Extensions"
  pod "UIComponents", :path => "./Modules/UIComponents"
  pod "UseCases", :path => "./Modules/UseCases"
  pod "Constants", :path => "./Modules/Constants"
end

target 'TestCalories' do
  platform :ios, '15.0'
  
  pod "★Main", :path => "./Modules/★Main"
  
  external_pods
  feature_pods
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
        config.build_settings['CODE_SIGN_IDENTITY'] = ""
      end
    end
  end
end
