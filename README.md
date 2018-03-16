# TMDbFramework

[![CI Status](http://img.shields.io/travis/saragiotto/TMDbFramework.svg?style=flat)](https://travis-ci.org/saragiotto/TMDbFramework)
[![Version](https://img.shields.io/cocoapods/v/TMDbFramework.svg?style=flat)](http://cocoapods.org/pods/TMDbFramework)
[![License](https://img.shields.io/cocoapods/l/TMDbFramework.svg?style=flat)](http://cocoapods.org/pods/TMDbFramework)
[![Platform](https://img.shields.io/cocoapods/p/TMDbFramework.svg?style=flat)](http://cocoapods.org/pods/TMDbFramework)
[![codecov.io](https://codecov.io/gh/saragiotto/TMDbFramework/branch/master/graphs/badge.svg)](https://codecov.io/gh/saragiotto/TMDbFramework/branch/master)
[![codebeat badge](https://codebeat.co/badges/84404fc1-6380-4eb7-9540-d567b1c16064)](https://codebeat.co/projects/github-com-saragiotto-tmdbframework-master)

TMDbFramework is swift pod to encapsulate all the themoviedb.org API.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
let tmdbModel = TMDb.shared
tmdbModel.apiKey = "your api key" //provided by themoviedb.org
tmdbModel.imageQuality = .medium
tmdbModel.listMoviesOf(type: .upComing) { response, movieList in
            
    for movie in movieList {
        print("Title \(movie.title!)")
        print("Poster Path \(movie.posterPath!)")
        print("id \(movie.id!)")
        print("Release Date \(movie.releaseDate!)")
    }
}
```

## Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Swift 4 

## Installation

TMDbFramework is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TMDbFramework"
```

## Author

Leonardo Saragiotto, leonardo.saragiotto@gmail.com

## License

TMDbFramework is available under the MIT license. See the LICENSE file for more info.
