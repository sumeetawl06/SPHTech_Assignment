//
//  CoreDataManager.swift
//  MyRecords
//
//  Created by Sumeet Agarwal on 12/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let EntityName = "Record"
    
    func isExist(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        let res = try! context.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    
    func saveDataInLocal(recordsList: [Records]) -> [Record] {
        
        for record in recordsList {
            guard let objId = record._id else {
                return self.fetchRecords()
            }
            if (!isExist(id: "\(objId)")) {
                guard let entityDescription = NSEntityDescription.entity(forEntityName: EntityName, in: context) else {
                    return self.fetchRecords()
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
        return self.fetchRecords()
    }
    
    func fetchRecords() -> [Record] {
        var records: [Record]?
        do {
            records = try context.fetch(Record.fetchRequest())
        }
        catch {
            return []
        }
        return records ?? []
    }
}
