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
    
    let apiClient = RecordsApiClient()
    let urlReq = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=5"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var records: [Record]?
    var reloadDataInTable = Bindable<Bool>(false)
    let EntityName = "Record"
    var dataModel = [RecordByYearModel]()
    var refreshUI : (() -> Void)?
    
    
    override init() {
        super.init()
        fetchDataFromServer()
    }
    
    func fetchDataFromServer() {
        apiClient.stubEnabled = true
        apiClient.getRecords(url: urlReq) { (records, response, error) in
            self.saveDataInLocal(recordsList: records ?? [])
        }
    }
    
    func isExist(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        let res = try! context.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    
    func saveDataInLocal(recordsList: [Records]) {
        for record in recordsList {
            guard let objId = record._id else {
                return
            }
            if (!isExist(id: "\(objId)")) {
                guard let entityDescription = NSEntityDescription.entity(forEntityName: EntityName, in: context) else {
                    return
                }
                let dataRecord = Record(entity: entityDescription, insertInto: context)
                dataRecord.volumeOfMobileData = record.volume_of_mobile_data
                dataRecord.id = "\(record._id ?? 0)"
                dataRecord.quarter = record.quarter
                do {
                    try context.save()
                }catch {
                    print("Failed to save data")
                }
            }
        }
        _ = self.prepareDataModel()
        self.refreshUI?()
    }
    
    func fetchRecords() -> [Record] {
        do {
            self.records = try context.fetch(Record.fetchRequest())
        }
        catch {
            return []
        }
        return records ?? []
    }
    
    @discardableResult
    func prepareDataModel() -> [RecordByYearModel] {
        let localDataModels = self.fetchRecords()
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
