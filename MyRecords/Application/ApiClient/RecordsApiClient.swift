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
    var stubEnabled = false

    func getRecords(completionHandler: @escaping ([Records]?, URLResponse?, Error?) -> Void) {
        
        guard !stubEnabled else {
            guard let url = Bundle.main.url(forResource: AppConstants.resourceFile, withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    completionHandler([], nil, nil)
                    return
            }
            do {
                let responseModel = try JSONDecoder().decode(APIResponse.self, from: data)
                completionHandler(responseModel.result?.records, nil, nil)
            }catch {
               completionHandler([], nil, nil)
            }
            return
        }
        
        self.apiClient.get(with: AppConstants.dataSourceRequestURL) { (records, response, error) in
            completionHandler(records, response, error)
        }
    }
    
}
