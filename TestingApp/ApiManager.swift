//
//  ApiManager.swift
//  ProfileApp
//
//  Created by Raj Maurya on 02/10/19.
//  Copyright © 2019 Raj Maurya. All rights reserved.
//

import Foundation

fileprivate let apiURl:String  = "https://gist.githubusercontent.com/Rajmaurya8085/cc208cd0b29fe01aaae1f3b2308ac55b/raw/8eb479113fdc9dc7289c85ee2f7873aa32d6c115/json"

typealias CallBack = (Profile)->Void
func getUserData(callBackHandler :@escaping CallBack){
    
    guard let  url = URL(string: apiURl) else{return }
    
    let session = URLSession.shared
    let task  = session.dataTask(with: url) {(data, response, error) in
        
        guard let responseData = data else{return}
      let jsonObject = try? JSONSerialization.jsonObject(with:responseData, options: .allowFragments)
       
        do {
        let decoder = JSONDecoder()
        let dataModel =   try decoder.decode(Profile.self, from: responseData)
            print(dataModel.about.summary)
            callBackHandler(dataModel)
            
        }
        catch let parseringError{
            print(parseringError)
        }
    
    }
    
    task.resume()
}
