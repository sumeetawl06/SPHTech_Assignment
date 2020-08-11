//
//  RecordByYearModel.swift
//  MyRecords
//
//  Created by Sumeet Agarwal on 11/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import UIKit

class RecordByYearModel: NSObject {
    var year: String?
    var dataConsumption: Double?
    var dataConsumptionByQuarter = [String: Double]()
}
