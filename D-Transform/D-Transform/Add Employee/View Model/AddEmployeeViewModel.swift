//
//  AddEmployeeViewModel.swift
//  D-Transform
//
//  Created by Rohit on 6/1/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import RealmSwift

class AddEmployeeViewModel {
    
    let realm = try! Realm()
    var employeeBands: [EmployeeBand] = [EmployeeBand]()
    var employeeDesignations: [Designation] = [Designation]()
    var employeeCompetencys: [Competency] = [Competency]()
    var projectsArray: [Projects] = [Projects]()
    
    /// Use this method if user want to get list of all meployee band values
    ///
    /// - Returns: list of all EmployeeBand
    func getAllEmployeeBand() -> [EmployeeBand] {
        return EmployeeBand.allCases
    }
    
    /// Use this method if user want to get list of all meployee band values
    ///
    /// - Returns: list of all EmployeeBand
    func getAllEmployeeCompetencyList() -> [Competency] {
        return Competency.allCases
    }
    
    /// Use this method if user want to get list of all meployee band values
    ///
    /// - Returns: list of all EmployeeBand
    func getAllEmployeeDesignation() -> [Designation] {
        return Designation.allCases
    }
    
    func setAllDataForView() {
        employeeBands = getAllEmployeeBand()
        employeeCompetencys = getAllEmployeeCompetencyList()
        employeeDesignations = getAllEmployeeDesignation()
        let projectViewModel = ProjectViewModel()
        projectsArray = projectViewModel.getAllProjectList()
    }
    
    func saveEmployeeData(employee: Employee, projectName: String, completion: @escaping () -> ()) {
        let projectViewModel = ProjectViewModel()
        let employeeProject = projectViewModel.getProjectFrom(projectName: projectName)
        employee.employeeProject = employeeProject
        try! realm.write {
            realm.add(employee)
        }
        completion()
    }
    
}

enum EmployeeBand: String, CaseIterable {
    case U1
    case U2
    case U3
    case U4
    case P1
    case P2
    case E1
}

enum Designation: String, CaseIterable {
    case Developer = "Developer"
    case SrDeveloper = "Senior Developer"
    case Designer = "Designer"
    case TechLead = "Tech Lead"
    case TeamLead = "Team Lead"
    case ProjectManager = "Project Manager"
    case DeliveryHead = "Delivery Head"
}

enum Competency: String, CaseIterable  {
    case iOS
    case Android
    case Hybrid
    case UX
    case Testing
}
