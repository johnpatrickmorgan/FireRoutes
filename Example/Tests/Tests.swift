// https://github.com/Quick/Quick

import Quick
import Nimble
import FireRoutes
import Alamofire

class TableOfContentsSpec: QuickSpec {
    
    override func spec() {
        
        let manager = SessionManager.default
        
        describe("A string route") {
            let route = StringRoute()
            
            context("with delayed stubbed data") {
                let data = dataForFile("StringRouteSample", type:"txt")!
                let stub = (RequestResult.success(data), 0.1)
                
                it("should succeed") {
                    waitUntil { done in
                        manager.stub(route, stub: stub) { (response) -> Void in
                            expect(response.result.value).toNot(beNil())
                            expect(response.result.error).to(beNil())
                            expect(response.result.value).to(equal("Hello world!"))
                            done()
                        }
                    }
                }
            }
        }
        
        describe("A JSON route") {
            let route = JSONRoute()
            
            context("with delayed stubbed data") {
                let data = dataForFile("JSONRouteSample", type:"json")!
                let stub = (RequestResult.success(data), 0.1)
                
                it("should succeed") {
                    waitUntil { done in
                        manager.stub(route, stub: stub) { (response) -> Void in
                            expect(response.result.value).toNot(beNil())
                            expect(response.result.error).to(beNil())
                            let representation = response.result.value as? NSDictionary
                            expect(representation).toNot(beNil())
                            let greeting = representation!["greeting"] as? String
                            expect(greeting).to(equal("Hello world!"))
                            done()
                        }
                    }
                }
            }
        }
        
        describe("An image route") {
            let route = ImageRoute(userId:"jmorgan")
            
            context("with delayed stubbed data") {
                let data = dataForFile("ImageRouteSample", type:"png")!
                let stub = (RequestResult.success(data), 0.1)
                
                it("should succeed") {
                    waitUntil { done in
                        manager.stub(route, stub: stub) { (response) -> Void in
                            expect(response.result.value).toNot(beNil())
                            expect(response.result.error).to(beNil())
                            expect(response.result.value!.size.width).to(equal(640.0))
                            done()
                        }
                    }
                }
            }
        }
        
        describe("A mapped model route") {
            let route = MappedModelRoute()
            
            context("with delayed stubbed data") {
                let data = dataForFile("MappedModelRouteSample", type:"json")!
                let stub = (RequestResult.success(data), 0.1)
                
                it("should succeed") {
                    waitUntil { done in
                        manager.stub(route, stub: stub) { (response) -> Void in
                            expect(response.result.value).toNot(beNil())
                            expect(response.result.error).to(beNil())
                            let mappedModel = response.result.value
                            expect(mappedModel!.exampleURL).toNot(beNil())
                            expect(mappedModel!.exampleInt).to(equal(42))
                            expect(mappedModel!.exampleString).to(equal("Hello world!"))
                            done()
                        }
                    }
                }
            }
        }
    }
}


func dataForFile(_ filename: String, type: String?) -> Data? {
    
    let bundle = Bundle(for: StringRoute.self)
    if let url = bundle.url(forResource: filename, withExtension: type) {
        return try! Data(contentsOf: url)
    }
    return nil
}
