//
//  MyRecordsTests.swift
//  MyRecordsTests
//
//  Created by Sumeet Agarwal on 2/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import XCTest
@testable import MyRecords

class MyRecordsTests: XCTestCase {

    let viewModel = RecordListViewModel()
    let client = RecordsApiClient()
    let dataManager = CoreDataManager()
    
    override func setUp() {
        client.stubEnabled = true
        viewModel.apiClient.stubEnabled = true
    }
    
    func testAPICall() {
        client.getRecords { (records, response, error) in
            XCTAssertFalse(records?.isEmpty ?? true, "No Record Found")
            XCTAssertNil(response, "Response is other than nil")
            XCTAssertNil(error, "error is other than nil")
        }
    }
    
    func testFetchData() {
        let exp = expectation(description: "Should Fetch Data")
        viewModel.refreshUI = {
            XCTAssertFalse(self.viewModel.dataModel.isEmpty, "No Record Found")
            exp.fulfill()
        }
        viewModel.fetchDataFromServer()
        waitForExpectations(timeout: 3)
    }
    
    func testPrepareDataModel() {
        let results = viewModel.prepareDataModel()
        XCTAssertFalse(results.isEmpty, "No Records Founds")
    }
    
    func testGetYearFromRecord() {
        guard let firstElement = viewModel.coreDataManager.fetchRecords().first  else {
            return
        }
        let year = viewModel.getYearFromRecord(record: firstElement)
        XCTAssertNotNil(Int(year), "Invalid Year")
    }
    
    func testGetQuarterFromRecord() {
        guard let firstElement = viewModel.coreDataManager.fetchRecords().first  else {
            return
        }
        let quarter = viewModel.getQuaterFromRecord(record: firstElement)
        let expectedOutPut = ["Q1", "Q2", "Q3", "Q4"]
        XCTAssertTrue( expectedOutPut.contains(quarter), "Invalid Quarter")
    }
    
    func testIsRecordExist() {
        guard let existingRecordID = viewModel.coreDataManager.fetchRecords().first?.id  else {
            return
        }
        let exist = dataManager.isExist(id: existingRecordID)
        XCTAssertTrue( exist, "Record Does not Exist")
    }
    
    func testSaveDataInLocal() {
        client.getRecords { (records, response, error) in
            let savedRecords = self.dataManager.saveDataInLocal(recordsList: records ?? [])
            XCTAssertNotNil(savedRecords, "Records not Found")
        }
    }
    
    func testFetchRecords() {
        let records = dataManager.fetchRecords()
        XCTAssertNotNil(records, "Records not Found")
    }
}
