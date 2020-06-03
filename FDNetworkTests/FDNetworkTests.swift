//
//  FDNetworkTests.swift
//  FDNetworkTests
//
//  Created by Emre Ertan on 2.04.2020.
//  Copyright © 2020 Emre Ertan. All rights reserved.
//

import XCTest
@testable import FDNetwork

class FDNetworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let e = expectation(description: "Alamofire")
        FDNetworkRouter.UDID = "xyz"
        FDNetworkRouter.appVersion = "6.0"
        FDNetworkRouter.URLType = .custom(base: "http://192.168.0.13:8080/v1", oldBase: "http://192.168.0.13:5000/")
        FDNetworkClient.authenticateDevice(shopid: "SyWSL-Y5M", pincode: "9524", numberOfRetry: 3) { data, error in
            print(data)
            print(error)
            e.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
