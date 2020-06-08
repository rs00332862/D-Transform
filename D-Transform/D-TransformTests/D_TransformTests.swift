//
//  D_TransformTests.swift
//  D-TransformTests
//
//  Created by Rohit on 5/19/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import XCTest
@testable import D_Transform

class D_TransformTests: XCTestCase {

    let projecViewModel = ProjectViewModel()
    let addEmployeeViewModel = AddEmployeeViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    func testSaveProjectData() {
        let expectation = self.expectation(description: "Project Save Success")
        projecViewModel.saveProject(name: "Test Project Save") {
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }

    func testSaveEmployeeData() {
        let employee = Employee()
        employee.employeeName = "Rohit Shivankar"
        employee.employeeNumber = "332862"
        employee.employeeBand = "U4"
        employee.employeeDesignation = "Tech Lead"
        employee.employeeComptency = "iOS"
        let expectation = self.expectation(description: "Employee Save Success")
        addEmployeeViewModel.saveEmployeeData(employee: employee, projectName: "Test Project Save") {
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testEmployeeSearchResult() {
        let employeeViewModel = EmployeeListViewModel()
        employeeViewModel.getAllEmployeeData {
            employeeViewModel.filterEmployeeDataWith(string: "Rohit") {
                XCTAssertEqual(employeeViewModel.employeeFilteredArray.count, 1)
            }
        }
    }
    
    func testEmployeeSearchResultData() {
        let employeeViewModel = EmployeeListViewModel()
        employeeViewModel.getAllEmployeeData {
            employeeViewModel.filterEmployeeDataWith(string: "Rohit") {
                let firstSearchedResult = employeeViewModel.employeeFilteredArray[0]
                XCTAssertEqual(firstSearchedResult.employeeNumber, "332862")
                XCTAssertEqual(firstSearchedResult.employeeName, "Rohit Shivankar")
            }
        }
    }

}
