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
    var viewModel: RecordListViewModel! {
        didSet {
            viewModel.fetchDataFromServer()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RecordListViewModel()
        self.title = "Records List"
        self.refreshUI()
        self.viewModel.prepareDataModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func refreshUI() {
        
        self.viewModel.refreshUI = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordsTableViewCell
        let record = self.viewModel.dataModel[indexPath.row]
        cell.titleLabel.text = "Year - \(String(describing: record.year ?? ""))"
        cell.consumptionLabel.text = "Data Consumption - \(String(describing: record.dataConsumption ?? 0))"
        cell.imageButton.isHidden = !viewModel.isClickableImageVisible(recordByYear: record)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

