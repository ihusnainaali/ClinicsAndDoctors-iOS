//
//  HomeVCTest.swift
//  ClinicsAndDoctorsTests
//
//  Created by Hernan Paez on 28/12/17.
//  Copyright © 2017 InfinixSoft. All rights reserved.
//

import XCTest
@testable import ClinicsAndDoctors

class test_2_HomeVCTest: XCTestCase {
  var vc: HomeVC!
  var oldVC:UIViewController?
  
  override func setUp() {
    super.setUp()
    let sb = UIStoryboard(name: "Main", bundle: Bundle(for: HomeVC.self))
    vc = sb.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
    _ = vc.view
    
    oldVC = UIApplication.shared.keyWindow?.rootViewController
    UIApplication.shared.keyWindow?.rootViewController = vc
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
    UIApplication.shared.keyWindow?.rootViewController = oldVC
  }
  
  func testSpecialityLoad() {
    let exp = expectation(description: "speciality load")
    vc.loadSpecialitys()
      .then { _ -> Void in
        XCTAssert(self.vc.specialitysNames.isEmpty == false, "Should load Specialities")
        exp.fulfill()
    }
    
    waitForExpectations(timeout: 60, handler: nil)
  }
  
  func testClinicsLoad() {
    let exp = expectation(description: "speciality load")
    vc.loadClinics(radius: 10000000)
      .then { _ -> Void in
        XCTAssert(ClinicModel.clinics.isEmpty == false, "Should load Clinics")
        exp.fulfill()
    }
    
    waitForExpectations(timeout: 60, handler: nil)
  }

  func testDoctorLoad() {
    let exp = expectation(description: "speciality load")
    vc.loadDoctors(specialityId: nil, clinicId: nil)
      .then { _ -> Void in
        XCTAssert(DoctorModel.doctors.isEmpty == false, "Should load Doctors")
        exp.fulfill()
    }
    
    waitForExpectations(timeout: 60, handler: nil)
  }

  
//  func testLoadData() {
//    vc.loadData()
//
//    while SpecialityModel.specialities.isEmpty ||
//      ClinicModel.clinics.isEmpty ||
//      DoctorModel.doctors.isEmpty
//    {
//      RunLoop.current.run(mode: .defaultRunLoopMode, before: Date.distantFuture)
//    }
//
//    XCTAssert(SpecialityModel.specialities.isEmpty == false, "Should load Specialities")
//    XCTAssert(ClinicModel.clinics.isEmpty == false, "Should load Clinics")
//    XCTAssert(DoctorModel.doctors.isEmpty == false, "Should load Doctors")
//  }
  
  
}
