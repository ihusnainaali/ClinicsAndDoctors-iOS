//
//  ClinicsAndDoctorsUITests.swift
//  ClinicsAndDoctorsUITests
//
//  Created by Hernan Paez on 28/12/17.
//  Copyright © 2017 InfinixSoft. All rights reserved.
//

import XCTest
@testable import ClinicsAndDoctors

class ClinicsAndDoctorsUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test1_Login() {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    let app = XCUIApplication()
    app.buttons["LOGIN WITH MOBILE"].tap()
    
    let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    let textField = element.children(matching: .textField).element
    textField.tap()
    textField.typeText("1155633535")
    
    let secureTextField = element.children(matching: .secureTextField).element
    secureTextField.tap()
    secureTextField.tap()
    secureTextField.typeText("fernetconcoca")
    app.buttons["LOGIN"].tap()
  }
  
}
