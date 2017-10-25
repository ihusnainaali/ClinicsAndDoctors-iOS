//
//  ISClient.swift
//  ClinicsAndDoctors
//
//  Created by reinier on 14/10/17.
//  Copyright © 2017 InfinixSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ISClient: NSObject {
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let sharedInstance = ISClient()
    //let listOfServices:[Service]?
    //Local
    private var baseURL = (UIApplication.shared.delegate as! AppDelegate).webUrl
    var specialtysList = [Speciality]()
    var clinicsList = [Clinic]()
    var doctorsList = [Doctor]()
    //Internet
    //private var baseURL : String = ""
    //Wify for Iphone
    //private var baseURL : String = ""
    private var access_token = (UIApplication.shared.delegate as! AppDelegate).access_token
    private var reachabilityManager : Alamofire.NetworkReachabilityManager
    
    override init() {
        self.reachabilityManager = Alamofire.NetworkReachabilityManager(host: baseURL)!
        self.reachabilityManager.startListening()
        super.init()
    }
    
    // MARK: - Encoders and Decoders Image
    func encodeImageToBase64String(image:UIImage)->String{
        let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
    
    func decodeImageFromBase64String(strBase64:String)->UIImage{
        let dataDecoded:NSData = NSData(base64Encoded: strBase64, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
        return decodedimage
    }
    
    
    
    // MARK: Alamofire Request
    func request(endPoint: String, Params: Parameters, method: HTTPMethod? = .get, encoding: ParameterEncoding? = JSONEncoding.prettyPrinted , completion: @escaping ((_ data: JSON) -> Void)) {
        let headers = ["Content-Type" : "application/json"]
        // if let token = appDelegate.token{}
        //headers["access_token"] = appDelegate.token
        print(self.baseURL+endPoint)
        let c = Alamofire.request(self.baseURL + endPoint, method: method!, parameters: Params, encoding: encoding!, headers: headers)
            .responseJSON() { response in
                print("Alamofire Response \(response)")
                switch response.result {
                case .success(let json):
                    print(JSON(json))
                    completion(JSON(json))
                case .failure:
                    let status = ["code": "time_out",
                                  "detail": "Secure connection to the server cannot be made"]
                    let Json = JSON(status)
                    completion(Json)
                    print("error en la peticion")
                    //if let err = error as? AFError {
                        /*if err.isResponseSerializationError {
                        } else {
                        }*/
                    //}
                    print("error: \(response.error?.localizedDescription)")
                }
        }
        print(c.debugDescription)
    }
    
    // MARK: Authentication
    func Login(phone:String,password:String, closure: ((_ success:Bool?, _ error:String?) -> Void)?){
        let parameters : Parameters = [
            "phone_number": phone,
            "password": password
            //"otherParameter":"value"
        ]
        
        //let postData = try JSONSerialization.js(withJSONObject: parameters, options: [])
        
        request(endPoint: "login", Params: parameters, method: .post) { (json) in
            //let responseList :NSMutableArray = NSMutableArray()
            
            if json["code"].stringValue == "time_out"{
                print("error")
                closure!(false,json["detail"].stringValue)
            }
            else if json["code"].stringValue == "LOGIN_UNSUCCESSFUL" {
                print(json)
                closure!(false,json["detail"].stringValue)
            }
            else{
                User.sharedInstance.SetData(representationJSON: json)
                print("Phone: \(User.sharedInstance.phone_number)")
                print("Username: \(User.sharedInstance.full_name)")
                self.access_token = json["access_token"].stringValue
                print("Token ===> \(self.access_token)")
                closure!(true,nil)
            }
        }
    }
    
    func RegisterWhitEmail(fullName:String, phone_number: String, email:String, password:String, picture:UIImage, closure: ((_ success:Bool?, _ error:String?) -> Void)?){
        let parameters : Parameters = [
            "full_name": fullName,
            "phone_number": phone_number,
            "email": email,
            "password": password,
            "picture" : self.encodeImageToBase64String(image: picture)
            //"otherParameter":"value"
        ]
        request(endPoint: "register", Params: parameters, method: .post) { (json) in
            //let responseList :NSMutableArray = NSMutableArray()
            
            if json["code"].stringValue == "time_out"{
                print("error")
                closure!(false,json["detail"].stringValue)
            }
            else if json["code"].stringValue == "REGISTER_UNSUCCESSFUL" {
                print(json)
                closure!(false,json["detail"].stringValue)
            }
            else{
                print(json.arrayValue)
                closure!(true,nil)
            }
        }
    }
    
    func ForgotPassword(phone_number:String, closure: ((_ success:Bool?, _ error:String?) -> Void)?){
        let parameters : Parameters = [
            "phone_number": phone_number
            //"otherParameter":"value"
        ]
        request(endPoint: "forgot_password", Params: parameters, method: .post) { (json) in
            //let responseList :NSMutableArray = NSMutableArray()
            
            if json["code"].stringValue == "time_out"{
                print("error")
                closure!(false,json["detail"].stringValue)
            }
            else if json["code"].stringValue == "USER_NOT_FOUND" {
                print(json)
                closure!(false,json["detail"].stringValue)
            }
            else{
                print(json.arrayValue)
                closure!(true,nil)
            }
        }
    }
    
    func RegisterWithFacebook(fb_social_token:String, fb_id:String, closure: ((_ success:Bool?, _ error:String?) -> Void)?){
        let parameters : Parameters = [
            "fb_social_token": fb_social_token,
            "fb_id":fb_id
        ]
        request(endPoint: "register_with_fb", Params: parameters, method: .post) { (json) in
            //let responseList :NSMutableArray = NSMutableArray()
            
            if json["code"].stringValue == "time_out"{
                print("error")
                closure!(false,json["detail"].stringValue)
            }
            else if json["code"].stringValue == "REGISTER_WITH_FB_UNSUCCESSFUL" {
                print(json)
                closure!(false,json["detail"].stringValue)
            }
            else{
                User.sharedInstance.SetData(representationJSON: json)
                print("Phone: \(User.sharedInstance.phone_number)")
                print("Username: \(User.sharedInstance.full_name)")
                self.access_token = json["access_token"].stringValue
                print("Token ===> \(self.access_token)")
                closure!(true,nil)
            }
        }
    }
    
    // MARK: GetData
    
    //Get All Speciality in Sistem
    func GetSpecialtys( closure: ((_ success:[Speciality]?, _ error:String?) -> Void)?){
        let parameters : Parameters = [
            //"access_token": self.access_token
            //"otherParameter":"value"
            :
            ]
        request(endPoint: "get_specialties", Params: parameters, method: .post) { (json) in
            if json["code"].stringValue == "time_out"{
                print("error")
                closure!([],json["detail"].stringValue)
            }
            else if json["code"].stringValue == "GET_SPECIALTIES_UNSUCCESSFUL" {
                print(json)
                closure!([],json["detail"].stringValue)
            }
            else{
                
                print(json.arrayValue)
                for item in json.arrayValue {
                    self.specialtysList.append(Speciality.init(representationJSON: item))
                }
                closure!(self.specialtysList,nil)
            }
        }
    }
    
    //Get Clinic for specific speciality
    func GetClinics(specialty_id:String = "", is_favorite:Bool = false, latitude: Double, longitude: Double, radius: Int, user_id: Int, closure: ((_ success:Bool?, _ error:String?) -> Void)?){
        var parameters : Parameters = [
            "access_token": self.access_token,
            "is_favorite": is_favorite,
            "latitude": latitude,
            "longitude": longitude,
            "radius": radius,
            "user_id":user_id
        ]
        if specialty_id != "" {
            parameters.updateValue(specialty_id, forKey: "specialty_id")
        }
        
        request(endPoint: "get_clinics", Params: parameters) { (json) in
            //var clinicsList = [Clinic]()
            if json["code"].stringValue == "time_out"{
                print("error")
                closure!(false,json["detail"].stringValue)
            }
            else if json["code"].stringValue == "GET_CLINICS_UNSUCCESSFUL" {
                print(json)
                closure!(false,json["detail"].stringValue)
            }
            else{
                print(json.arrayValue)
                for item in json.arrayValue {
                    self.clinicsList.append(Clinic.init(representationJSON: item))
                }
                closure!(true,nil)
            }
        }
    }
    
    //Get Doctors for specific clinic or/ands speciality
    func GetDoctors(specialty_id:String = "", clinic_id:String = "", page:String = "", is_favorite:Bool = false, latitude: Double, longitude: Double, radius: Int, user_id: Int, closure: ((_ success:Bool?, _ error:String?) -> Void)?){
        var parameters : Parameters = [
            "access_token": self.access_token,
            "is_favorite": is_favorite,
            "latitude": latitude,
            "longitude": longitude,
            "radius": radius,
            "user_id":user_id
        ]
        if specialty_id != "" {
            parameters.updateValue(specialty_id, forKey: "specialty_id")
        }
        if clinic_id != "" {
            parameters.updateValue(clinic_id, forKey: "clinic_id")
        }
        
        
        request(endPoint: "get_doctors", Params: parameters) { (json) in
            //var clinicsList = [Clinic]()
            if json["code"].stringValue == "time_out"{
                print("error")
                closure!(false,json["detail"].stringValue)
            }
            else if json["code"].stringValue == "GET_DOCTORS_UNSUCCESSFUL" {
                print(json)
                closure!(false,json["detail"].stringValue)
            }
            else{
                print(json.arrayValue)
                for item in json.arrayValue {
                    self.doctorsList.append(Doctor.init(representationJSON: item))
                }
                closure!(true,nil)
            }
        }
    }
    
    //Add Clinic or Doctor to Favorite for User
    func AddFavorite(user_id:String,clinic_id:String = "", doctor_id: String = "", closure: ((_ success:Bool?, _ error:String?) -> Void)?){
        var parameters : Parameters = [
            "user_id": user_id,
        ]
        if clinic_id != "" {
            parameters.updateValue(clinic_id, forKey: "clinic_id")
        }
        else{
            parameters.updateValue(doctor_id, forKey: "doctor_id")
        }
        
        //let postData = try JSONSerialization.js(withJSONObject: parameters, options: [])
        
        request(endPoint: "add_favorite", Params: parameters, method: .post) { (json) in
            if json["code"].stringValue == "time_out"{
                print("error")
                closure!(false,json["detail"].stringValue)
            }
            else if json["code"].stringValue == "ADD_FAVORITE_UNSUCCESSFUL" {
                print(json)
                closure!(false,json["detail"].stringValue)
            }
            else{
                closure!(true,nil)
            }
        }
    }
    
    //Remove Clinic or Doctor as Favorite for User
    func RemoveFavorite(user_id:String,clinic_id:String = "", doctor_id: String = "", closure: ((_ success:Bool?, _ error:String?) -> Void)?){
        var parameters : Parameters = [
            "user_id": user_id,
            ]
        if clinic_id != "" {
            parameters.updateValue(clinic_id, forKey: "clinic_id")
        }
        else{
            parameters.updateValue(doctor_id, forKey: "doctor_id")
        }
        
        //let postData = try JSONSerialization.js(withJSONObject: parameters, options: [])
        
        request(endPoint: "add_favorite", Params: parameters, method: .post) { (json) in
            if json["code"].stringValue == "time_out"{
                print("error")
                closure!(false,json["detail"].stringValue)
            }
            else if json["code"].stringValue == "ADD_FAVORITE_UNSUCCESSFUL" {
                print(json)
                closure!(false,json["detail"].stringValue)
            }
            else{
                closure!(true,nil)
            }
        }
    }
}

