//
//  ClinicsAndDoctorsTests.swift
//  ClinicsAndDoctorsTests
//
//  Created by Hernan Paez on 28/12/17.
//  Copyright © 2017 InfinixSoft. All rights reserved.
//

import XCTest
@testable import ClinicsAndDoctors

class test_1_ClinicsAndDoctorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRoundedButton() {
      let button = RoundedButton(frame: CGRect.zero)
      button.borderColor = "#ffffff"
      button.borderW = 1
      
      XCTAssert(button.borderW == 1, "Border With of bordered button is different")
      XCTAssert(button.borderColor == "#ffffff", "Border Color of bordered button is different")

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
