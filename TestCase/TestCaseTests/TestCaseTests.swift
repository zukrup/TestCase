//
//  TestCaseTests.swift
//  TestCaseTests
//
//  Created by musa fedakar on 10.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import XCTest
@testable import TestCase

class TestCaseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jsonData = "{\"get\":\"countries\",\"parameters\":[],\"errors\":[],\"results\":4,\"response\":[\"Afghanistan\",\"Albania\",\"Algeria\",\"Andorra\"]}"
        let jsonResult = JSON(parseJSON: jsonData)
        let countriesObj = ApiResponseObject<String>(json: jsonResult, objectList: jsonResult["response"].arrayValue.map { $0.stringValue} )
        
        
        let jsonStatData = "{\"get\":\"statistics\",\"parameters\":{\"country\":\"usa\"},\"errors\":[],\"results\":1,\"response\":[{\"continent\":\"North-America\",\"country\":\"USA\",\"population\":330848770,\"cases\":{\"new\":\"+15408\",\"active\":1145446,\"critical\":16939,\"recovered\":621439,\"1M_pop\":\"5666\",\"total\":1874731},\"deaths\":{\"new\":\"+921\",\"1M_pop\":\"326\",\"total\":107846},\"tests\":{\"1M_pop\":\"55817\",\"total\":18466841},\"day\":\"2020-06-02\",\"time\":\"2020-06-02T21:00:06+00:00\"}]}"
        let jsonStatResult = JSON(parseJSON: jsonStatData)
        let statObj = ApiResponseObject<Country>(json: jsonStatResult, object: try JSONDecoder().decode(Country.self, from: jsonStatResult["response"].arrayValue.first!.rawData()))
        
        XCTAssert(statObj.response.first?.deaths?.numbersNew == "+921", "Pass")
        XCTAssert(countriesObj.response.count == 4, "Pass")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
