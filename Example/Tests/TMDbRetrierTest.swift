//
//  TMDbRetrierTest.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 10/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Nimble
import Quick
import TMDbFramework

class TMDbRetrierTest: QuickSpec {
    
    override func spec() {
        describe("Test Retrier Handler") {
            
            let tmdbPod:TMDb = TMDb.sharedInstance
            
            it("Request 42 times Genres List") {
                var succesTimes = 0
                var atemptTimes = 0
                
                waitUntil(timeout: 25.0) { done in
                    
                    for _ in 1...42 {
                        atemptTimes += 1
                        print("atemptTimes - \(atemptTimes)")
                        DispatchQueue.global(qos: .background).async {
                            tmdbPod.loadMovies(listType: .UpComming) { listResult, movieList in
                                
                                if (movieList != nil){
                                    succesTimes += 1
                                    print("succesTimes - \(succesTimes)")
                                }
                                
                                if (atemptTimes == succesTimes) {
                                    expect(movieList).notTo(beNil())
                                    done()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
