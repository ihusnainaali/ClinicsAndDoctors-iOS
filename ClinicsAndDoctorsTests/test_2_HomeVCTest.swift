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
  
  func testLoadData() {
    vc.loadData()
    
    while SpecialityModel.specialities.isEmpty ||
      ClinicModel.clinics.isEmpty ||
      DoctorModel.doctors.isEmpty
      {
      RunLoop.current.run(mode: .defaultRunLoopMode, before: Date.distantFuture)
    }
    
    XCTAssert(SpecialityModel.specialities.isEmpty == false, "Should load Specialities")
    XCTAssert(ClinicModel.clinics.isEmpty == false, "Should load Clinics")
    XCTAssert(DoctorModel.doctors.isEmpty == false, "Should load Doctors")
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
