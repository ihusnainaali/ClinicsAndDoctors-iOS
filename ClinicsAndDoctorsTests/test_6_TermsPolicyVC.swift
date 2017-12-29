//
//  HomeVCTest.swift
//  ClinicsAndDoctorsTests
//
//  Created by Hernan Paez on 28/12/17.
//  Copyright © 2017 InfinixSoft. All rights reserved.
//

import XCTest
@testable import ClinicsAndDoctors

class test_6_TermsPolicyVC: XCTestCase {
  var vc: TermsPolicyVC!
  var oldVC:UIViewController?
  
  override func setUp() {
    super.setUp()
    let sb = UIStoryboard(name: "Main", bundle: Bundle(for: TermsPolicyVC.self))
    vc = sb.instantiateViewController(withIdentifier: "TermsPolicyVC") as! TermsPolicyVC
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
  
  func testLoadTermData() {
    vc.isTerms = true
    vc.textView.text = ""
    vc.loadData()
    
    while vc.textView.text.isEmpty == true
      {
      RunLoop.current.run(mode: .defaultRunLoopMode, before: Date.distantFuture)
    }
    
    XCTAssert(vc.textView.text.isEmpty == false, "Should load text")
  }
  
  func testLoadPrivacyData() {
    vc.isTerms = false
    vc.textView.text = ""
    vc.loadData()
    
    while vc.textView.text.isEmpty == true
    {
      RunLoop.current.run(mode: .defaultRunLoopMode, before: Date.distantFuture)
    }
    
    XCTAssert(vc.textView.text.isEmpty == false, "Should load text")
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
