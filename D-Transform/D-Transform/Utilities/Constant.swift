//
//  Constant.swift
//  D-Transform
//
//  Created by Rohit on 5/20/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class Constant {
    enum EmployeeBand {
        case U1
        case U2
        case U3
        case U4
        case P1
        case p2
        case E1
    }
    
    enum EmployeeDesignation {
        case Developer
        case Designer
        case TechLead
        case TeamLead
        case ProjectManager
        case DeliveryHead
    }
    
    enum Competency  {
        case iOS
        case Android
        case Hybrid
        case UX
        case Tester
        case NA
    }
    
    static let employeeCustomCellIdentifier = "EmployeeCustomCell"
    static let projectCellIdentifier = "projectCellIdentifier"
}
