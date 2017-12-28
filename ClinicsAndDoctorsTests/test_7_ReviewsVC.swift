//
//  HomeVCTest.swift
//  ClinicsAndDoctorsTests
//
//  Created by Hernan Paez on 28/12/17.
//  Copyright © 2017 InfinixSoft. All rights reserved.
//

import XCTest
@testable import ClinicsAndDoctors

class test_7_ReviewsVC: XCTestCase {
  var vc: ReviewsVC!
  var oldVC:UIViewController?
  
  override func setUp() {
    super.setUp()
    let sb = UIStoryboard(name: "Main", bundle: Bundle(for: ReviewsVC.self))
    vc = sb.instantiateViewController(withIdentifier: "ReviewsVC") as! ReviewsVC
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

  func testLoadPrivacyData() {
    vc.clinicId = "12"
    vc.loadInfo()
    
    while vc.reviews.isEmpty == false
    {
      RunLoop.current.run(mode: .defaultRunLoopMode, before: Date.distantFuture)
    }
    
    XCTAssert(SpecialityModel.specialities.isEmpty == false, "Should load reviews")
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
