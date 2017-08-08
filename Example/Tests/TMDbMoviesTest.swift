//
//  TMDbMoviesTest.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 07/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import TMDbFramework

class TMDbMoviesTest: QuickSpec {
    override func spec() {
        describe("Test TMDbMovieManager and TMDbMovie") {
            
            let tmdbPod:TMDb = TMDb.sharedInstance
            
            it("Request upcomming movies ommiting page param") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .UpComming) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 upcomming movies") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .UpComming, page: 1) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 upcomming movies") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .UpComming, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
        }
    }
}
