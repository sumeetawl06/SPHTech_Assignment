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
    
    
    override init() {
        super.init()
        fetchDataFromServer()
    }
    
    func fetchDataFromServer() {
        apiClient.getRecords(url: urlReq) { (records, response, error) in
            print(records)
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
                var dataRecord = Record(entity: entityDescription, insertInto: context)
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
        fetchRecords()
    }
    
    func fetchRecords() {
        do {
            self.records = try context.fetch(Record.fetchRequest())
            self.reloadDataInTable.value = true
        }
        catch {
            
        }
    }
    
    //    func prepareTableDataByYear() -> [Records] {
    //        <#function body#>
    //    }
    
}
