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
    
    let allowButtonPredicate = NSPredicate(format: "label == 'Always Allow' || label == 'Allow'")
    //1st alert
    _ = addUIInterruptionMonitor(withDescription: "Allow to access your location?") { (alert) -> Bool in
      let alwaysAllowButton = alert.buttons.matching(allowButtonPredicate).element.firstMatch
      if alwaysAllowButton.exists {
        alwaysAllowButton.tap()
        return true
      }
      return false
    }
    
    XCUIApplication().launch()
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test00_ForgotPassword() {    
    let app = XCUIApplication()
    sleep(4)
    
    if app.navigationBars["ClinicsAndDoctors.HomeVC"].exists {
      let itemButton = app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"]
      itemButton.tap()
      app.buttons["Logout"].tap()
      itemButton.tap()
      app.staticTexts["Login / Register"].tap()
      sleep(1)
    }
    
    app.buttons["LOGIN WITH MOBILE"].tap()
    app.buttons["Forgot your password?"].tap()
    
    let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
    textField.tap()
    textField.typeText("+5491131078636")
    
    let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    element.children(matching: .other).element.children(matching: .textField).element.tap()
    element.tap()

    app.buttons["RECOVER PASSWORD"].tap()
    
    sleep(4)
  }
  
  func test01_Login() {
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

    let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    element2.tap()

    app.buttons["LOGIN"].tap()
    
    sleep(6)
  }
  
  func test02_loadFavorites() {
    
    let app = XCUIApplication()
    
    if app.buttons["LOGIN WITH MOBILE"].exists {
      app.buttons["LOGIN WITH MOBILE"].tap()
      
      let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
      let textField = element.children(matching: .textField).element
      textField.tap()
      textField.typeText("1155633535")
      
      let secureTextField = element.children(matching: .secureTextField).element
      secureTextField.tap()
      secureTextField.tap()
      secureTextField.typeText("fernetconcoca")
      
      let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
      element2.tap()

      app.buttons["LOGIN"].tap()
      sleep(4)
    }
    
    sleep(4)
    
    let clinicsanddoctorsHomevcNavigationBar = app.navigationBars["ClinicsAndDoctors.HomeVC"]
    clinicsanddoctorsHomevcNavigationBar.buttons["Item"].tap()
    app.buttons["Favorites"].tap()
    
    sleep(4)

    app.buttons["Clinics"].tap()
    app.buttons["Doctors"].tap()
  }
  
  func test03_loadDoctor() {
    
    let app = XCUIApplication()
    if app.buttons["LOGIN WITH MOBILE"].exists {
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
      
      let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
      element2.tap()

      sleep(4)
    }

    sleep(4)

    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["Favorites"].tap()

    sleep(4)

    let ratingElement = app.tables/*@START_MENU_TOKEN@*/.otherElements["Rating"]/*[[".cells.otherElements[\"Rating\"]",".otherElements[\"Rating\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    ratingElement.tap()
    
    let button = app.navigationBars["DETAIL"].children(matching: .button).element
    button.tap()
    
    sleep(4)

    app.buttons["Clinics"].tap()
    app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Little Haiti Health Center")/*[[".cells.containing(.staticText, identifier:\"7065.5 Km Away\")",".cells.containing(.staticText, identifier:\"Little Haiti Health Center\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements["Rating"].tap()
    button.tap()
    
  }
  
  func test04_AboutUs() {
    
    let app = XCUIApplication()
    if app.buttons["LOGIN WITH MOBILE"].exists {
      app.buttons["LOGIN WITH MOBILE"].tap()
      
      let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
      let textField = element.children(matching: .textField).element
      textField.tap()
      textField.typeText("1155633535")
      
      let secureTextField = element.children(matching: .secureTextField).element
      secureTextField.tap()
      secureTextField.tap()
      secureTextField.typeText("fernetconcoca")
      
      let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
      element2.tap()

      app.buttons["LOGIN"].tap()
      sleep(4)
    }

    sleep(4)

    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["About Us"].tap()
    app.navigationBars["About Us"].buttons["Back"].tap()
    
  }
  
  func test05_DoctorReviews() {
    
    let app = XCUIApplication()
    if app.buttons["LOGIN WITH MOBILE"].exists {
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
      sleep(4)
    }

    sleep(4)

    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["Favorites"].tap()
    sleep(4)

    app.tables/*@START_MENU_TOKEN@*/.otherElements["Rating"]/*[[".cells.otherElements[\"Rating\"]",".otherElements[\"Rating\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    app.buttons["Reviews"].tap()
    
  }
  
  func test06_DoctorProfileMapAction() {
    
    let app = XCUIApplication()
    sleep(4)
    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["Favorites"].tap()
    
    sleep(4)
    
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["Jose Fernandez"]/*[[".cells.staticTexts[\"Jose Fernandez\"]",".staticTexts[\"Jose Fernandez\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    app.buttons["whiteFillPhone"].tap()
    app.buttons["ic clinic location"].tap()
  }
  
  func test07_DoctorProfileShareAction() {
    let app = XCUIApplication()
    sleep(4)
    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["Favorites"].tap()
    
    sleep(4)

    app.tables/*@START_MENU_TOKEN@*/.staticTexts["Jose Fernandez"]/*[[".cells.staticTexts[\"Jose Fernandez\"]",".staticTexts[\"Jose Fernandez\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    app.buttons["whiteFillPhone"].tap()
    app.buttons["ic share"].tap()
    app.buttons["Cancel"].tap()
  }
  
  func test08_MyProfile() {
    
    let app = XCUIApplication()
    sleep(4)

    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["See Profile"].tap()
    
  }
  
  func test09_EditMyName() {
    
    let app = XCUIApplication()
    sleep(4)
    
    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["See Profile"].tap()
    
    let button = app.navigationBars["PROFILE"].children(matching: .button).element(boundBy: 1)
    button.tap()
    
    let textField = app.scrollViews.otherElements.containing(.button, identifier:"Change Password").children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).children(matching: .textField).element
    textField.tap()
    textField.clearAndEnterText(text: "Luis Hernan Paez")
    button.tap()
    
  }
  
  func test10_ChangePassword() {
    
    let app = XCUIApplication()
    sleep(4)

    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["See Profile"].tap()
    app.navigationBars["PROFILE"].children(matching: .button).element(boundBy: 1).tap()
    app.scrollViews.otherElements.buttons["Change Password"].tap()
    let changePasswordAlert = app.alerts["Change Password"]
    let collectionViewsQuery = changePasswordAlert.collectionViews
    collectionViewsQuery.textFields["Current password"].typeText("fernetconcoca")
    
    let newPasswordTextField = collectionViewsQuery.textFields["New password"]
    newPasswordTextField.tap()
    newPasswordTextField.tap()
    newPasswordTextField.typeText("fernetconcoca")
    
    let reTypeTheNewPasswordTextField = collectionViewsQuery.textFields["Re-type the new password"]
    reTypeTheNewPasswordTextField.tap()
    reTypeTheNewPasswordTextField.tap()
    reTypeTheNewPasswordTextField.typeText("fernetconcoca")
    changePasswordAlert.buttons["Confirm"].tap()
    
    sleep(4)
  }
  
  func test11_CustomDoctorRate() {
    
    let app = XCUIApplication()
    sleep(4)
    
    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["Favorites"].tap()
    
    sleep(4)
    
    let faces:[String] = ["face1", "face2", "face3", "face4", "face5"]
    
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["Jose Fernandez"]/*[[".cells.staticTexts[\"Jose Fernandez\"]",".staticTexts[\"Jose Fernandez\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    app.buttons["Reviews"].tap()
    app.buttons["UPDATE RATING"].tap()
    app.buttons[faces[Int(arc4random_uniform(3))]].tap()
    
    let scrollViewsQuery = app.scrollViews
    scrollViewsQuery.children(matching: .button).matching(identifier: "grayEllipse").element(boundBy: 3).tap()
    
    let textField = scrollViewsQuery.children(matching: .textField).element
    textField.tap()
    textField.clearAndEnterText(text: "This is an automated test.")

    app/*@START_MENU_TOKEN@*/.buttons["SUBMIT"]/*[[".scrollViews.buttons[\"SUBMIT\"]",".buttons[\"SUBMIT\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    sleep(2)
  }
  
  func test11_DoctorRate() {
    
    let app = XCUIApplication()
    sleep(4)
    
    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["Favorites"].tap()
    
    sleep(4)
    
    let faces:[String] = ["face1", "face2", "face3", "face4", "face5"]
    
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["Jose Fernandez"]/*[[".cells.staticTexts[\"Jose Fernandez\"]",".staticTexts[\"Jose Fernandez\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    app.buttons["Reviews"].tap()
    app.buttons["UPDATE RATING"].tap()
    app.buttons[faces[Int(arc4random_uniform(3))]].tap()
    app.scrollViews.children(matching: .button).matching(identifier: "grayEllipse").element(boundBy: 1).tap()
    app/*@START_MENU_TOKEN@*/.buttons["SUBMIT"]/*[[".scrollViews.buttons[\"SUBMIT\"]",".buttons[\"SUBMIT\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    sleep(2)
  }

  
  func test12_AddRemoveDoctorFromFavorites() {
    
    let app = XCUIApplication()
    
    sleep(4)

    app.navigationBars["ClinicsAndDoctors.HomeVC"].buttons["Item"].tap()
    app.buttons["Favorites"].tap()
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["Jose Fernandez"]/*[[".cells.staticTexts[\"Jose Fernandez\"]",".staticTexts[\"Jose Fernandez\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    let icFavOffButton = app.buttons["ic fav off"]
    icFavOffButton.tap()
    sleep(3)
    icFavOffButton.tap()
    sleep(1)
    
  }
}

extension XCUIElement {
  /**
   Removes any current text in the field before typing in the new value
   - Parameter text: the text to enter into the field
   */
  func clearAndEnterText(text: String) {
    guard let stringValue = self.value as? String else {
      XCTFail("Tried to clear and enter text into a non string value")
      return
    }
    
    self.tap()
    
    let deleteString = stringValue.characters.map { _ in "\u{8}" }.joined(separator: "")
    
    self.typeText(deleteString)
    self.typeText(text)
  }
}
