//
//  Employee.swift
//  D-Transform
//
//  Created by Rohit on 6/3/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import RealmSwift

class Employee: Object {
    @objc dynamic var employeeID = UUID().uuidString
    @objc dynamic var employeeName: String?
    @objc dynamic var employeeNumber: String?
    @objc dynamic var employeeDesignation: String?
    @objc dynamic var employeeBand: String?
    @objc dynamic var employeeProject: Projects?
    @objc dynamic var employeeComptency: String?
    
    override static func primaryKey() -> String? {
      return "employeeID"
    }
}
