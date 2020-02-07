# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

# This article helped me while setting up Cocoapods for multiple projects in a workspace.
# https://medium.com/@youvalv/cocoapods-for-an-existing-multi-project-workspace-1fb73f46fede

use_frameworks!

workspace 'CleanArchitectureDemo'
project 'CleanArchitectureDemo/CleanArchitectureDemo.xcodeproj'

def project_pods
  # Add pods in order to use them in the main project
end

def service_pods
  pod 'Alamofire', '~> 4.8.2'
end

# Pods for project
target 'CleanArchitectureDemo' do
  project 'CleanArchitectureDemo/CleanArchitectureDemo.xcodeproj'
  project_pods
end

# Pods for Service
target 'Service' do
  project 'Service/Service.xcodeproj'
  service_pods
end

# https://github.com/CocoaPods/CocoaPods/issues/5334
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
      config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
    end
  end
end
