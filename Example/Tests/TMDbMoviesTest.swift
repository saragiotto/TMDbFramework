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
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .UpComming) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 upcomming movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .UpComming, page: 1) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 upcomming movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .UpComming, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request top rated movies ommiting page param") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .TopRated) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 top rated movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .TopRated, page: 1) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 top rated movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .TopRated, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }

            it("Request popular movies ommiting page param") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .Popular) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 popular movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .Popular, page: 1) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 popular movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .Popular, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Detail movie") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .UpComming) { listResult, movieList in
                        
                        let movie = movieList!.first
                        
                        
                        tmdbPod.movieDetailFor(movie!) { movie in
                        
                            expect(movie).notTo(beNil())
                            done()
                        }
                    }
                }
            }
        }
    }
}
