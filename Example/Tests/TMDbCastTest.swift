//
//  TMDbCastTest.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 16/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import TMDbFramework

class TMDbCastTest: QuickSpec {
    override func spec() {
        describe("Test TMDbMovieManager and TMDbCast") {
            
            let tmdbPod:TMDb = TMDb.shared
            
            it("Request upcomming movies and then its Cast") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .upComing) { listResult, movieList in
                        
                        let movie = movieList!.first
                        
                        
                        tmdbPod.creditsFor(movie!) { movie in
                            
                            expect(movie!.cast).notTo(beNil())
                            expect(movie!.cast?.count) > 0
                        
                            done()
                        }
                    }
                }
            }
        }
    }
}
