//
//  AboutVC.swift
//  ClinicsAndDoctors
//
//  Created by Osmely Fernandez on 14/2/18.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import UIKit
import MessageUI

class AboutVC: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var aboutImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        aboutImageView.image = UIImage(named: "aboutimage".localized)

    }


    @IBAction func socialBtnAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: "Select Social Network".localized, preferredStyle:.actionSheet )
        
        let twitter = UIAlertAction(title: "Twitter".localized, style: .default) { _ in
            self.openTwitter(screenName: "Clickdoc_")
        }
        let instagram = UIAlertAction(title: "Instagram".localized, style: .default) { _ in
            self.openInstagram(Username: "clickdoc_")
        }
        
        
        alert.addAction(twitter)
        alert.addAction(instagram)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func emailBtnAction(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["Info@Clickdoc.me"])
            mail.setMessageBody("", isHTML: false)
            present(mail, animated: true)
        }else{
            let sendMailErrorAlert = UIAlertController.init(title: "Failed",
                                                            message: "Unable to send email. Please check your email settings and try again.", preferredStyle: .alert)
            sendMailErrorAlert.addAction(UIAlertAction.init(title: "OK",
                                                            style: .default, handler: nil))
            self.present(sendMailErrorAlert,
                         animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func openInstagram(Username:String){
        let appURL = NSURL(string: "instagram://user?username=\(Username)")!
        let webURL = NSURL(string: "https://instagram.com/\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                application.open(appURL as URL, options: [:], completionHandler: nil)
            }else{
                application.openURL(appURL as URL)
            }
        } else {
            if #available(iOS 10.0, *) {
                application.open(webURL as URL, options: [:], completionHandler: nil)
            }else{
                application.openURL(webURL as URL)
            }
        }
    }
    
    func openTwitter(screenName:String){
        let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
        let webURL = NSURL(string: "https://twitter.com/\(screenName)")!
        
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL as URL)
            }
        } else {
            //redirect to safari because the user doesn't have Instagram
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(webURL as URL)
            }
        }
    }
}



