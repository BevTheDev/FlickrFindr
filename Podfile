source 'https://cdn.cocoapods.org/'

platform :ios, '18.0'

inhibit_all_warnings!
use_frameworks!

workspace 'FlickrFindr'
project 'FlickrFindr'

target 'FlickrFindr' do

  # This would normally only be in the test target,
  # but is included in the main target here for demo purposes
  pod 'OHHTTPStubs/Swift'
  
  # Testing
  target 'FlickrFindrTests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "18.0"
    end
  end
end

