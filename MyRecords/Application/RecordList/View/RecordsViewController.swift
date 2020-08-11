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

    @IBOutlet weak var tableView: UITableView!
    let viewModel = RecordListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Records List"
        self.setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupBinding() {
        
        self.viewModel.reloadDataInTable.bind(listener: { [weak self](reload) in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordsTableViewCell
        let record = self.viewModel.records?[indexPath.row]
        cell.titleLabel.text = record?.volumeOfMobileData
        cell.typeLabel.text = record?.quarter
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

