//
//  HomeVCTest.swift
//  ClinicsAndDoctorsTests
//
//  Created by Hernan Paez on 28/12/17.
//  Copyright © 2017 InfinixSoft. All rights reserved.
//

import XCTest
@testable import ClinicsAndDoctors

class test_8_ClinincVC: XCTestCase {
  var vc: ClinincDetailVC!
  var oldVC:UIViewController?
  
  override func setUp() {
    super.setUp()
    let sb = UIStoryboard(name: "Main", bundle: Bundle(for: ClinincDetailVC.self))
    vc = sb.instantiateViewController(withIdentifier: "ClinincDetailVC") as! ClinincDetailVC
    _ = vc.view
    
    oldVC = UIApplication.shared.keyWindow?.rootViewController
    UIApplication.shared.keyWindow?.rootViewController = vc
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
    UIApplication.shared.keyWindow?.rootViewController = oldVC
    UserModel.currentUser = nil

  }

  func testLoadPrivacyData() {
    vc.clinicId = "12"
    vc.loadData()
    
    XCTAssert(ClinicModel.by(id: vc.clinicId) != nil, "Should load clinic")
  }
  
}
