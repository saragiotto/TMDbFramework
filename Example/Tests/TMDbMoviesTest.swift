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
            
            it("Request page 3 upcomming movies") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .UpComming, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request top rated movies ommiting page param") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .TopRated) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 top rated movies") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .TopRated, page: 1) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 top rated movies") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .TopRated, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }

            it("Request popular movies ommiting page param") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .Popular) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 popular movies") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .Popular, page: 1) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 popular movies") {
                
                waitUntil { done in
                    tmdbPod.loadMovies(listType: .Popular, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
        }
    }
}