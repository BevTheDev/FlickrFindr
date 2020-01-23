source 'https://cdn.cocoapods.org/'

platform :ios, '12.0'

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
