//
//  RecordsApiClient.swift
//  MyRecords
//
//  Created by Sumeet Agarwal on 11/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import UIKit

class RecordsApiClient: BaseApiClient {
    
    let apiClient = BaseApiClient()
    
    func getRecords(url: String, completionHandler: @escaping ([Records]?, URLResponse?, Error?) -> Void) {
        
        self.apiClient.get(with: url) { (records, response, error) in
            completionHandler(records, response, error)
        }
    }
    
}
