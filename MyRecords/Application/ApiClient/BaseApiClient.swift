//
//  ApiClient.swift
//  MyRecords
//
//  Created by Sumeet Agarwal on 11/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import UIKit

class BaseApiClient: NSObject {
    
    func get(with requestURL:String, completionHandler: @escaping ([Records]?, URLResponse?, Error?) -> Void) {
        
        guard let urlObj = URL(string: requestURL) else {
            return
        }
        
       let task = URLSession.shared.dataTask(with: urlObj) { (data, urlResponse, error) in
           if let data = data {
               do {
                   let responseModel = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
                if let items = responseModel.result?.records {
                       completionHandler(items, nil, nil)
                   }else{
                       let error_custom = NSError(domain: "", code: 400, userInfo: ["description" : "No more result found for your search."])
                       completionHandler(nil, nil, error_custom)
                   }
               } catch  {
                   let error_custom = NSError(domain: "", code: 400, userInfo: ["description" : "No more search result found."])
                   completionHandler(nil, nil, error_custom)
               }
           }else {
               let error_custom = NSError(domain: "", code: 400, userInfo: ["description" : "No more search result found."])
               completionHandler(nil, nil, error_custom)
           }
       }
       task.resume()
    }
}
