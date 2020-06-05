//
//  EmployeeCell.swift
//  D-Transform
//
//  Created by Rohit on 5/20/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeDesignation: UILabel!
    @IBOutlet weak var employeeCompetency: UILabel!
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var employeeProject: UILabel!
    @IBOutlet weak var employeeNumber: UILabel!
    
    func setUpCellData(employeeData: Employee) {
        employeeDesignation.text = employeeData.employeeDesignation
        employeeName.text = "\(employeeData.employeeName!) (\(employeeData.employeeBand!))" 
        employeeCompetency.text = employeeData.employeeComptency
        employeeProject.text = employeeData.employeeProject?.projectName
        employeeNumber.text = employeeData.employeeNumber
    }
    
}
