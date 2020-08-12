//
//  MyRecordsUITests.swift
//  MyRecordsUITests
//
//  Created by Sumeet Agarwal on 2/8/20.
//  Copyright © 2020 Sumeet Agarwal. All rights reserved.
//

import XCTest

class MyRecordsUITests: XCTestCase {
    
    func testRecordListAndClickableButton() {
        
        let app = XCUIApplication()
        app.launch()
        app.tables/*@START_MENU_TOKEN@*/.buttons["graphImage"].press(forDuration: 0.5);/*[[".cells.buttons[\"graphImage\"]",".tap()",".press(forDuration: 0.5);",".buttons[\"graphImage\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeDown()
        
    }
}
