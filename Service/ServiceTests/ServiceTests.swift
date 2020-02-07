//
//  ServiceTests.swift
//  ServiceTests
//
//  Created by Gökhan Gültekin on 2020-02-06.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import XCTest
@testable import Service

class ServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testDecodeSearchResponse() {

        guard let data = try? ResourceLoader.loadFile(file: .search) else {
            fatalError("Response file could not be read.")
        }
        
        guard let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
            XCTFail("Search response could not be decoded.")
            return
        }
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response.resultCount, 50)
        XCTAssertEqual(response.results[0].artistName, "Behemoth")
    }
}
