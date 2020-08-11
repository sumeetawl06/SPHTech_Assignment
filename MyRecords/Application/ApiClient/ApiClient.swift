//
//  ApiClient.swift
//  MyRecords
//
//  Created by Sumeet Agarwal on 11/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import UIKit

class BaseApiClient: NSObject {
    
    func get(with requestURL:String, onSuccess: (Any)->Void, onfailure: (Error)->Void) {
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let url = URL(fileURLWithPath: requestURL)
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            print(data)
            print(response)
            print(error)
            
            if error == nil {
                onSuccess(data)
            }else {
                onfailure(error!)
            }
        })
        task.resume()
    }
}
