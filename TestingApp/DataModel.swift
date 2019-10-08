//
//  DataModel.swift
//  ProfileApp
//
//  Created by Raj Maurya on 03/10/19.
//  Copyright © 2019 Raj Maurya. All rights reserved.
//

import Foundation



struct Profile:Codable {
    private (set) var userinfo:UserInfo
    private (set) var experience:[Experience]
    private (set) var education:[Education]
    private (set) var about:About
    private (set) var Skills:Skills
    
    
    
    struct UserInfo:Codable {
        let backgroundImage :String?
        let firstname:String
        let headLine:String
        let lastName:String
        let userId :String
        let userImage:String
    }
    struct Experience :Codable {
        let company : String
        let description: String
        let endDate : String?
        let isCurrentWorkingPosition :Bool;
        let location :String?
        let startDate:String
        let title : String
    }
    
    struct Education :Codable{
        let  degree : String
        let description : String
        let endData : String
        let field_of_study:String
        let grade :String
        let school : String
        let start_Year : String
        let isHighest:Bool
    }
    
    struct About:Codable {
        let summary :String
    }
    struct Skills:Codable {
        var industryKnowledge:[SkillObj]
        var otherskills:[SkillObj]
        var tools_technology:[SkillObj]
    }
    struct SkillObj:Codable {
        let name :String
        let rate :Double
    }
}



extension Profile{
    var fullName:String{
        get {
            return "\(self.userinfo.firstname) \(self.userinfo.lastName)"
        }
    }
    
    var location:String? {
        get{
            let exp  = self.experience.filter { (exp) -> Bool in
                return  exp.isCurrentWorkingPosition == true
            }
            if exp.count  >= 1{
                return exp.first?.location
            }else{
               return self.experience.first?.location
            }
        }
    }
    
    var highestEducation:String{
        get {
            let educ = self.education.filter { (education) -> Bool in
                return education.isHighest
            }
            
            if educ.count > 0 {
                return "\(educ.first!.degree) . \(education.first!.school)"
            }
            else{
                return  "\(self.education.first!.degree) . \(self.education.first!.school)"
            }
        }
        
        
    }
}
