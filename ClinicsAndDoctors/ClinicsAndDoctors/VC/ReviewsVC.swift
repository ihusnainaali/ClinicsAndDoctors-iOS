//
//  ReviewsVC.swift
//  ClinicsAndDoctors
//
//  Created by Reinier Isalgue on 08/10/17.
//  Copyright © 2017 InfinixSoft. All rights reserved.
//

import UIKit
import Cosmos
import NVActivityIndicatorView


class ReviewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var loadingIm:UIImageView!
    @IBOutlet weak var doctorAvatarIm:RoundedImageView!
    @IBOutlet weak var nameLb:UILabel!
    @IBOutlet weak var myTableView:UITableView!
    @IBOutlet weak var rateView: CosmosView!

    var reviews = [ReviewModel]()
    var docId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        CreateGradienBackGround(view: self.view)
        
        if let doctor = DoctorModel.by(id: self.docId){
            self.updateWith(doctor: doctor)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.loadData()
    }

    private func updateWith(doctor: DoctorModel){
        if let url = URL(string: doctor.profile_picture){
            self.doctorAvatarIm.url = url
        }

        self.nameLb.text = doctor.full_name
        self.rateView.rating = doctor.rating
    }


    func loadData(){
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(loading)

        ISClient.sharedInstance.getReviews(clinicOrDoctorId: self.docId, objType: "doctor")
            .then { reviews -> Void in

                self.reviews = reviews
                self.myTableView.reloadData()

            }.always {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }.catch { error in
                if let e: LPError = error as? LPError { e.show() }
        }

    }

    
    // MARK: - Actions
    
    @IBAction func BackView(_ sender: AnyObject){
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - TableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerReview")
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        cell.updateWithData(self.reviews[indexPath.row])
        return cell
    }

}
