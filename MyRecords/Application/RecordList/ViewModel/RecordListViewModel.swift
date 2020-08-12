//
//  RecordListViewModel.swift
//  MyRecords
//
//  Created by Sumeet Agarwal on 11/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import UIKit
import CoreData

class RecordListViewModel: NSObject {
    
    var apiClient = RecordsApiClient()
    var dataModel = [RecordByYearModel]()
    var refreshUI : (() -> Void)?
    let coreDataManager = CoreDataManager()
    
    override init() {
        super.init()
    }
    
    func fetchDataFromServer() {
        apiClient.getRecords { (records, response, error) in
            let records = self.coreDataManager.saveDataInLocal(recordsList: records ?? [])
            if records.count > 0 {
                _ = self.prepareDataModel()
                self.refreshUI?()
            }
        }
    }
    
    @discardableResult
    func prepareDataModel() -> [RecordByYearModel] {
        let localDataModels = self.coreDataManager.fetchRecords()
        var recordByYearModels = [RecordByYearModel]()
        _ = localDataModels.map { (record) -> Void in
            
            let year = getYearFromRecord(record: record)
            if let existingRecord = recordByYearModels.first(where: { (recordByYearModel) -> Bool in
                return (recordByYearModel.year?.hasPrefix(year) ?? false)
            }) {
                existingRecord.dataConsumption! += Double(record.volumeOfMobileData ?? "0") ?? 0.0
                existingRecord.year = year
                existingRecord.dataConsumptionByQuarter[getQuaterFromRecord(record: record)] = Double(record.volumeOfMobileData ?? "0")
                recordByYearModels = recordByYearModels.filter({!$0.year!.hasPrefix(year)})
                recordByYearModels.append(existingRecord)
            } else {
                let recordByYear = RecordByYearModel()
                recordByYear.dataConsumption = Double(record.volumeOfMobileData ?? "0")
                recordByYear.year = year
                recordByYear.dataConsumptionByQuarter[getQuaterFromRecord(record: record)] = Double(record.volumeOfMobileData ?? "0")
                recordByYearModels.append(recordByYear)
            }
        }
        dataModel = recordByYearModels
        return dataModel
    }
        
    func getYearFromRecord(record: Record) -> String {
        return (record.quarter?.components(separatedBy: "-").first) ?? ""
    }
    
    func getQuaterFromRecord(record: Record) -> String {
        return (record.quarter?.components(separatedBy: "-").last) ?? ""
    }
    
    func isClickableImageVisible(recordByYear: RecordByYearModel) -> Bool {
        let Q1 = recordByYear.dataConsumptionByQuarter["Q1"] ?? 0
        let Q2 = recordByYear.dataConsumptionByQuarter["Q2"] ?? 0
        let Q3 = recordByYear.dataConsumptionByQuarter["Q3"] ?? 0
        let Q4 = recordByYear.dataConsumptionByQuarter["Q4"] ?? 0
        
        if Q1 > Q2 || Q2 > Q3 || Q3 > Q4  {
            return true
        }
        return false
     }
}
