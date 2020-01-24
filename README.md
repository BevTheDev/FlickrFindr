# FlickrFindr
A demo app that displays images via the Flickr API

<p align="left">
 <a href="https://travis-ci.com/BevTheDev/FlickrFindr/" target="_blank"><img src="https://travis-ci.com/BevTheDev/FlickrFindr.svg?branch=master" alt="Build Status"></a> 
</p>

## Features
- 91.9% unit test coverage
- Travis-CI build on every merge to master
- Two pages of recent uploads + search
- Seamless paging for more search results
- Search supports special characters
- Save up to five recent search terms
- Supports portrait and landscape mode
- Image title fades on tap event for better fullscreen viewing (most useful in landscape)
- All features except network mocking are built using only system frameworks
- Stubbed response data for the recent uploads request (because getRecent doesn't have a "safe" option :flushed:)

## Installation
This project uses Cocoapods to install the OHHTTPStubs pod and a Gemfile to manage the Cocoapods version.

Set up the workspace by running the following commands:
```
gem install bundler
bundle install
bundle exec pod install
```
Then open the .xcworkspace file.
