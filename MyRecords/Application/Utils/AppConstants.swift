//
//  AppConstants.swift
//  MyRecords
//
//  Created by Sumeet Agarwal on 12/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import Foundation

struct AppConstants {
    
    static let baseURL = "https://data.gov.sg/api/action/"
    static let dataStoreSearchAction = "datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit="
    static let maxNumberOfRecords = "100"
    static let dataSourceRequestURL = AppConstants.baseURL + AppConstants.dataStoreSearchAction + AppConstants.maxNumberOfRecords
    static let resourceFile = "MockData"
    static let entityName = "Record"
    static let listScreenTitle = "Records List"
}
