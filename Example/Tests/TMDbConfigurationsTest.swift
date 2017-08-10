//
//  TMDbConfigurationsTest.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 09/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import TMDbFramework

class TMDbConfigurationsTest: QuickSpec {
    override func spec() {
        
        describe("Test TMDbConfigurationManager and TMDbConfiguration for Low image quality") {
            let tmdbPod:TMDb = TMDb.sharedInstance
            
            beforeEach {
                tmdbPod.imageQuality = .Low
                tmdbPod.configurations = nil
                waitUntil(timeout: 5.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        tmdbPod.loadConfiguration({_ in done()})
                    }
                }
            }
            
            it("Load Configs Low") {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations).notTo(beNil())
                        done()
                    }
                }
            }
            
            it("Check backdrop Low")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.backdropSize).notTo(beNil())
                        expect(tmdbPod.configurations!.backdropSize!).to(equal("w300"))
                        done()
                    }
                }
                
            }
            
            it("Check logo Low")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.logoSize).notTo(beNil())
                        expect(tmdbPod.configurations!.logoSize!).to(equal("w45"))
                        done()
                    }
                }
                
            }
            
            it("Check poster Low")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.posterSize).notTo(beNil())
                        expect(tmdbPod.configurations!.posterSize!).to(equal("w92"))
                        done()
                    }
                }
                
            }
            
            it("Check profile Low")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.profileSize).notTo(beNil())
                        expect(tmdbPod.configurations!.profileSize!).to(equal("w45"))
                        done()
                    }
                }
                
            }
            
            it("Check still Low")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.stillSize).notTo(beNil())
                        expect(tmdbPod.configurations!.stillSize!).to(equal("w92"))
                        done()
                    }
                }
                
            }
        }
        
        describe("Test TMDbConfigurationManager and TMDbConfiguration for Medium image quality") {
            let tmdbPod:TMDb! = TMDb.sharedInstance
            
            beforeEach {
                tmdbPod.imageQuality = .Medium
                tmdbPod.configurations = nil
                waitUntil(timeout: 5.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        tmdbPod.loadConfiguration({_ in done()})
                    }
                }
            }
            
            it("Load Configs Medium") {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations).notTo(beNil())
                        done()
                    }
                }
            }
            
            it("Check backdrop Medium")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.backdropSize).notTo(beNil())
                        expect(tmdbPod.configurations!.backdropSize!).to(equal("w780"))
                        done()
                    }
                }
                
            }
            
            it("Check logo Medium")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.logoSize).notTo(beNil())
                        expect(tmdbPod.configurations!.logoSize!).to(equal("w300"))
                        done()
                    }
                }
                
            }
            
            it("Check poster Medium")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.posterSize).notTo(beNil())
                        expect(tmdbPod.configurations!.posterSize!).to(equal("w500"))
                        done()
                    }
                }
                
            }
            
            it("Check profile Medium")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.profileSize).notTo(beNil())
                        expect(tmdbPod.configurations!.profileSize!).to(equal("w185"))
                        done()
                    }
                }
                
            }
            
            it("Check still Medium")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.stillSize).notTo(beNil())
                        expect(tmdbPod.configurations!.stillSize!).to(equal("w185"))
                        done()
                    }
                }
                
            }
        }
        
        describe("Test TMDbConfigurationManager and TMDbConfiguration for High image quality") {
            let tmdbPod:TMDb! = TMDb.sharedInstance
            
            beforeEach {
                tmdbPod.imageQuality = .High
                tmdbPod.configurations = nil
                waitUntil(timeout: 5.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        tmdbPod.loadConfiguration({_ in done()})
                    }
                }
            }
            
            it("Load Configs High") {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations).notTo(beNil())
                        done()
                    }
                }
            }
            
            it("Check backdrop High")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.backdropSize).notTo(beNil())
                        expect(tmdbPod.configurations!.backdropSize!).to(equal("w1280"))
                        done()
                    }
                }
                
            }
            
            it("Check logo High")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.logoSize).notTo(beNil())
                        expect(tmdbPod.configurations!.logoSize!).to(equal("w500"))
                        done()
                    }
                }
                
            }
            
            it("Check poster High")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.posterSize).notTo(beNil())
                        expect(tmdbPod.configurations!.posterSize!).to(equal("w780"))
                        done()
                    }
                }
                
            }
            
            it("Check profile High")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.profileSize).notTo(beNil())
                        expect(tmdbPod.configurations!.profileSize!).to(equal("h632"))
                        done()
                    }
                }
                
            }
            
            it("Check still High")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.stillSize).notTo(beNil())
                        expect(tmdbPod.configurations!.stillSize!).to(equal("w300"))
                        done()
                    }
                }
                
            }
        }
        
        describe("Test TMDbConfigurationManager and TMDbConfiguration for VeryHigh image quality") {
            let tmdbPod:TMDb! = TMDb.sharedInstance
            
            beforeEach {
                tmdbPod.imageQuality = .VeryHigh
                tmdbPod.configurations = nil
                waitUntil(timeout: 5.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        tmdbPod.loadConfiguration({_ in done()})
                    }
                }
            }
            
            it("Load Configs VeryHigh") {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations).notTo(beNil())
                        done()
                    }
                }
            }
            
            it("Check backdrop VeryHigh")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.backdropSize).notTo(beNil())
                        expect(tmdbPod.configurations!.backdropSize!).to(equal("original"))
                        done()
                    }
                }
                
            }
            
            it("Check logo VeryHigh")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.logoSize).notTo(beNil())
                        expect(tmdbPod.configurations!.logoSize!).to(equal("original"))
                        done()
                    }
                }
                
            }
            
            it("Check poster VeryHigh")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.posterSize).notTo(beNil())
                        expect(tmdbPod.configurations!.posterSize!).to(equal("original"))
                        done()
                    }
                }
                
            }
            
            it("Check profile VeryHigh")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.profileSize).notTo(beNil())
                        expect(tmdbPod.configurations!.profileSize!).to(equal("original"))
                        done()
                    }
                }
                
            }
            
            it("Check still VeryHigh")  {
                waitUntil(timeout: 3.0) { done in
                    DispatchQueue.global(qos: .background).async {
                        expect(tmdbPod.configurations!.stillSize).notTo(beNil())
                        expect(tmdbPod.configurations!.stillSize!).to(equal("original"))
                        done()
                    }
                }
                
            }
        }
    }
}
