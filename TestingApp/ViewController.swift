//
//  ViewController.swift
//  TestingApp
//
//  Created by Raj Maurya on 02/10/19.
//  Copyright © 2019 Raj Maurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var profileData :Profile!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // self.view.backgroundColor =  .white
        
        self.title = "Profile Screen"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserData{[weak self] profileData in
            DispatchQueue.main.async {
            self?.profileData = profileData
            self?.tableView.reloadData()
            }
           
            
        }
    }


}


extension  ViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileData != nil ? 7 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfRow(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getdequeueResuableCell(from: tableView, at: indexPath, data: profileData) as? ProfileTableCell
        return cell!
    }
    
    func getNumberOfRow(section:Int) -> Int{
        switch section {
        case 0:
        return 1
        case 1:
        return 1
        case 2:
            return profileData.experience.count
        case 3:
        return profileData.education.count
        case 4:
        return profileData.Skills.industryKnowledge.count
        case 5:
            return profileData.Skills.tools_technology.count
        case 6:
            return profileData.Skills.otherskills.count
        default:
        return 1
        }
    }
}
