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
            
            let tmdbPod:TMDb = TMDb.shared
            
            it("Request upComing movies ommiting page param") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .upComing) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 upComing movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .upComing, page: 1) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 upComing movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .upComing, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request top rated movies ommiting page param") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .topRated) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 top rated movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .topRated, page: 1) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 top rated movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .topRated, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }

            it("Request popular movies ommiting page param") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .popular) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 popular movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .popular, page: 1) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 popular movies") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .popular, page: 3) { listResult, movieList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(movieList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Detail movie") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listMoviesOf(type: .upComing) { listResult, movieList in
                        
                        let movie = movieList!.first
                        
                        
                        tmdbPod.movieDetailFor(movie!) { movie in
                        
                            expect(movie).notTo(beNil())
                            done()
                        }
                    }
                }
            }
            
            it("Detail movie by id") {
                
                waitUntil(timeout: 8.0) { done in
                    tmdbPod.movieDetailFor(id: "550") { movie in
                        
                        expect(movie).notTo(beNil())
                        done()
                    }
                }
            }
            
            it("Movie list by castId") {
                
                waitUntil(timeout: 8.0) { done in
                    tmdbPod.movieCreditsFor(castId: "287") { movies in
                        
                        expect(movies).notTo(beNil())
                        expect(movies.count).to(beGreaterThan(0))
                        done()
                    }
                }
            }
        }
    }
}
