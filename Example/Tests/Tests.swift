//// https://github.com/Quick/Quick
//
import Quick
import Nimble
import FireRoutes
import Alamofire

class TableOfContentsSpec: QuickSpec {
    
    func dataForFile(filename: String, type: String?) -> NSData? {

        guard let url = NSBundle(forClass: self.dynamicType).URLForResource(filename, withExtension: type) else {
            return nil
        }
        return NSData(contentsOfURL: url)
    }
    
    override func spec() {
        
        let manager = Manager.sharedInstance
        
        describe("A string route") {
            let route = StringRoute()
            
            context("with delayed stubbed data") {
                let data = self.dataForFile("StringRouteSample", type:"txt")!
                route.stub = (RequestResult.Success(data), 0.1)
                
                it("should succeed") {
                    waitUntil { done in
                        manager.request(route) { (response) -> Void in
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
                let data = self.dataForFile("JSONRouteSample", type:"json")!
                route.stub = (RequestResult.Success(data), 0.1)
                
                it("should succeed") {
                    waitUntil { done in
                        manager.request(route) { (response) -> Void in
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
                let data = self.dataForFile("ImageRouteSample", type:"png")!
                route.stub = (RequestResult.Success(data), 0.1)
                
                it("should succeed") {
                    waitUntil { done in
                        manager.request(route) { (response) -> Void in
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
                let data = self.dataForFile("MappedModelRouteSample", type:"json")!
                route.stub = (RequestResult.Success(data), 0.1)
                
                it("should succeed") {
                    waitUntil { done in
                        manager.request(route) { (response) -> Void in
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
