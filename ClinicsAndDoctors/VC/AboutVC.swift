//
//  AboutVC.swift
//  ClinicsAndDoctors
//
//  Created by Osmely Fernandez on 14/2/18.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var aboutImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        aboutImageView.image = UIImage(named: "aboutimage".localized)

    }



}
