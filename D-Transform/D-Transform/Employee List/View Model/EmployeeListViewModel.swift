//
//  EmployeeListViewModel.swift
//  D-Transform
//
//  Created by Rohit on 6/3/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import RealmSwift

class EmployeeListViewModel {
    let realm = try! Realm()
    var employeeArray: [Employee] = [Employee]()
    var employeeFilteredArray: [Employee] = [Employee]()
    
    func getAllEmployeeData(completion: @escaping () -> ()) {
        let resultData = realm.objects(Employee.self)
        employeeArray = [Employee]()
        for employee in resultData {
            employeeArray.append(employee)
        }
        completion()
    }
    
    func getEmployeeListCount(isFiltrig: Bool) -> Int {
        if isFiltrig {
            return employeeFilteredArray.count
        } else {
            return employeeArray.count
        }
    }
    
    func getEmployeeData(indexPathRow: Int, isFiltrig: Bool) -> Employee {
        if isFiltrig {
            return employeeFilteredArray[indexPathRow]
        } else {
            return employeeArray[indexPathRow]
        }
    }
    
    func filterEmployeeDataWith(string: String, completion: @escaping () -> ()) {
        employeeFilteredArray = employeeArray.filter { (employee: Employee) -> Bool in
            return employee.employeeName!.lowercased().contains(string.lowercased())
        }
        completion()
    }
    
    func deleteEmployeeDataWith(indexPathRow: Int, isFiltrig: Bool, completion: @escaping () -> ()) {
        let employeeData = getEmployeeData(indexPathRow: indexPathRow, isFiltrig: isFiltrig)
       // let result = realm.object(ofType: Employee.self, forPrimaryKey: employeeData.employeeID)
        try! realm.write {
            realm.delete(employeeData)
        }
        completion()
    }
}
