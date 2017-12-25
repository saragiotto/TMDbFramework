//
//  TMDbImageTest.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 10/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import TMDbFramework

class TMDbImageTest: QuickSpec {
    
    override func spec() {
        describe("Test TMDbImageManager and TMDbImage for Medium backdrop") {
            
            let tmdbPod:TMDb = TMDb.sharedInstance
            
            let backdropPath = "/puV2PFq42VQPItaygizgag8jrXa.jpg"
            
            beforeEach {
                tmdbPod.imageQuality = .medium
                tmdbPod.configurations = nil
                waitUntil(timeout: 12.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        tmdbPod.loadConfiguration({_ in done()})
                    }
                }
            }
            
            it("Request image backdrop medium quality") {
                
                waitUntil(timeout: 12.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        tmdbPod.loadImageFor(path: backdropPath, type: .backdrop) {image in
                            
                            expect(image).notTo(beNil())
                            expect(image!.size!.width).to(equal(780.0))
                            done()
                        }
                    }
                }
            }
        }
        
        describe("Test TMDbImageManager and TMDbImage for High poster") {
            
            let tmdbPod:TMDb = TMDb.sharedInstance
            
            let posterPath = "/5qcUGqWoWhEsoQwNUrtf3y3fcWn.jpg"
            
            beforeEach {
                tmdbPod.imageQuality = .high
                tmdbPod.configurations = nil
                waitUntil(timeout: 8.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        tmdbPod.loadConfiguration({_ in done()})
                    }
                }
            }
            
            it("Request poster high quality") {
                
                waitUntil(timeout: 8.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        tmdbPod.loadImageFor(path: posterPath, type: .poster) {image in
                            
                            expect(image).notTo(beNil())
                            expect(image!.size!.width).to(equal(780.0))
                            done()
                        }
                    }
                }
            }
        }
        
        describe("Backdrop and Poster test") {
            
            let tmdbPod:TMDb = TMDb.sharedInstance
            
            it("Request images for movie") {
                
                waitUntil(timeout: 8.0) { done in
                    tmdbPod.imagesFor(movieId: 550) { imageList in
                        
                        expect(imageList?.count).to(beGreaterThan(0))
                        done()
                    }
                }
                
            }
        }
        
        describe("Video list test") {
            
            let tmdbPod:TMDb = TMDb.sharedInstance
            
            it("Request videos for movie") {
                
                waitUntil(timeout: 8.0) { done in
                    tmdbPod.videosFor(movieId: 550) { videoList in
                        
                        expect(videoList.count).to(beGreaterThan(0))
                        done()
                    }
                }
                
            }
        }
    }
}
