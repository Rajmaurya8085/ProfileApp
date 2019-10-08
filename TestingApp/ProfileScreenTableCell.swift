//
//  ProfileScreenTableCell.swift
//  TestingApp
//
//  Created by Raj Maurya on 08/10/19.
//  Copyright © 2019 Raj Maurya. All rights reserved.
//

import Foundation
import UIKit
import  Combine

func getIdetifire<Subject>(object:Subject)->String{
     let cellIdentifier = String(describing: object.self)
    return cellIdentifier
}

enum tableSection{
    case profileInfo
    case about
    case Experience(abcd:Int)
    case education(abcd:Int)
    case skill
}

func getdequeueResuableCell(from:UITableView, at indexPath:IndexPath, data:Profile?)->UITableViewCell{
    
    switch indexPath.section {
    case 0:
        let cell  =  ProfilrUserInfoCell.dequeueResuableCell(from: from, at: indexPath, with: getIdetifire(object: ProfilrUserInfoCell.self)) as?  ProfilrUserInfoCell
        cell?.setData(data: data!, index: indexPath)
        cell?.selectionStyle = .none
        return cell!
    case 1:
        let cell =  ProfileAboutCell.dequeueResuableCell(from: from, at: indexPath, with: getIdetifire(object: ProfileAboutCell.self)) as? ProfileAboutCell
        cell?.setData(data: data!.about, index: indexPath)
        cell?.selectionStyle = .none
       return cell!
    case 2...3:
        let cell  =  ProfileEducationCell.dequeueResuableCell(from: from, at: indexPath, with: getIdetifire(object: ProfileEducationCell.self)) as? ProfileEducationCell
        cell?.selectionStyle = .none
        if indexPath.section == 2{
            cell?.setData(EXp: data!.experience[indexPath.row], index: indexPath)
        }else{
            cell?.setData(education: data!.education[indexPath.row], index: indexPath)
        }
        return cell!
    case 4...7:
        let cell  =   ProfilSkillInfoCell.dequeueResuableCell(from: from, at: indexPath, with: getIdetifire(object: ProfilSkillInfoCell.self)) as? ProfilSkillInfoCell
        cell?.setData(data: data!.Skills, index: indexPath)
        cell?.selectionStyle = .none
        return cell!
    default:
        return  ProfileEducationCell.dequeueResuableCell(from: from, at: indexPath, with: getIdetifire(object: ProfileEducationCell.self))
    }
}


class ProfileTableCell:UITableViewCell{
    static func dequeueResuableCell<T: UITableViewCell>(from tableView: UITableView, at indexPath: IndexPath,with identifier:String ) -> T
      {
        let cell = tableView.dequeueReusableCell(withIdentifier: getIdetifire(object:identifier ), for: indexPath)
          return cell as? T ?? T(style: .default, reuseIdentifier:getIdetifire(object:identifier ) )
      }
    
    func setData(data:Data, index:IndexPath){
        
    }
}

class ProfilrUserInfoCell :ProfileTableCell{

    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var educationLbl: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    
    func setData(data:Profile, index:IndexPath){
        userName.text = data.fullName
        titleLbl.text = data.userinfo.headLine
        currentLocationLbl.text = data.location
        educationLbl.text = data.highestEducation
        userImage.image = UIImage(named:"raj copy")
        backGroundImage.image = UIImage(named: "images")
       }
}

class ProfileAboutCell :ProfileTableCell{
    var indexPath:IndexPath?
    @IBOutlet weak var aboutLbl: UILabel!
    
    func setData(data:Profile.About, index:IndexPath){
        aboutLbl.text = data.summary
           
       }
}

class ProfileEducationCell :ProfileTableCell{

    @IBOutlet weak var titleNameLbl: UILabel!
    @IBOutlet weak var titleButtomConst: NSLayoutConstraint!
    @IBOutlet weak var nameTopConst: NSLayoutConstraint!
    
    @IBOutlet weak var imege: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var orgLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    var index:IndexPath!
    
    func setData(EXp:Profile.Experience, index:IndexPath){
        self.index = index
       manageLayOut(indexPath: index)
        titleLbl.text = EXp.title
        timeLbl.text = EXp.date
        orgLbl.text  = EXp.company
    }
    
    func setData(education:Profile.Education, index:IndexPath){
        self.index = index
        titleLbl.text = education.degree
        orgLbl.text  = education.school
        timeLbl.text = education.date
       manageLayOut(indexPath: index)
    }
    func manageLayOut(indexPath:IndexPath){
    if indexPath.row == 0{
         titleButtomConst.priority = UILayoutPriority.defaultHigh
         nameTopConst.priority = UILayoutPriority.defaultLow
         titleNameLbl.isHidden = false
         titleNameLbl.text  = indexPath.section  == 2 ? "Experience" : "Education"
        imege?.image  = UIImage(named: indexPath.section  == 2 ? "ust":"akg")
          }
      else {
          titleButtomConst.priority = UILayoutPriority.defaultLow
          nameTopConst.priority = UILayoutPriority.defaultHigh
            titleNameLbl.isHidden = true
         imege?.image  = UIImage(named: indexPath.section  == 2 ? "algow":"bd")
             }
}
}

class ProfilSkillInfoCell :ProfileTableCell{
    @IBOutlet weak var sectionTitleLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    var indexPath:IndexPath!
    @IBOutlet weak var nameTopFromUperConst: NSLayoutConstraint!
    @IBOutlet weak var nameTopFromSuperConst: NSLayoutConstraint!
    
    func setData(data:Profile.Skills, index:IndexPath){
        indexPath = index
           manageLayOut()
        switch index.section {
        case 4:
              sectionTitleLbl.text = "Industry Knowledge"
              nameLbl.text = data.industryKnowledge[index.row].name
              ratingLbl.text = "\(data.industryKnowledge[index.row].rate) / \(10)"
         case 5:
              sectionTitleLbl.text = "Tools & Technology"
              nameLbl.text = data.tools_technology[index.row].name
               ratingLbl.text = " \(data.tools_technology[index.row].rate) / \(10)"
            
        case 6:
               sectionTitleLbl.text = "Other Skills"
               nameLbl.text = data.otherskills[index.row].name
               ratingLbl.text = " \(data.otherskills[index.row].rate) / \(10)"
        default:
            print(" ")
        }
       }
    
    
    private func manageLayOut(){
        if indexPath.row == 0{
            nameTopFromUperConst.priority = UILayoutPriority.defaultHigh
            nameTopFromSuperConst.priority = UILayoutPriority.defaultLow
            sectionTitleLbl.isHidden = false
        }else{
            nameTopFromUperConst.priority = UILayoutPriority.defaultLow
            nameTopFromSuperConst.priority = UILayoutPriority.defaultHigh
            sectionTitleLbl.isHidden = true
            layoutIfNeeded()
            setNeedsLayout()
        }
    }
}




extension Profile.Education{
    var date:String{
        return "\(self.start_Year ) - \(self.endData) "
    }
}
extension Profile.Experience{
    var date:String{
        return "\(self.startDate ) - \(self.endDate!) "
    }
}
 





