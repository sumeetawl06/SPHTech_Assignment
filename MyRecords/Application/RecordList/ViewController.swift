//
//  ViewController.swift
//  MyRecords
//
//  Created by Sumeet Agarwal on 2/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import UIKit
import CoreData

class RecordsViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    var records: [Record]?
    
    let buttonAction: (() -> ()) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Records List"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchRecords()
    }
    
    func fetchRecords() {
        do {
            self.records = try context.fetch(Record.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordsTableViewCell
        let record = self.records?[indexPath.row]
        cell.data = record
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = self.records?[indexPath.row] {
            context.delete(obj)
            do {
                try context.save() // <- remember to put this :)
                self.fetchRecords()
            } catch {
                // Do something... fatalerror
            }
        }
    }
}

