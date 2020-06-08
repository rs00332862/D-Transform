//
//  AddEmployeeViewController.swift
//  D-Transform
//
//  Created by Rohit on 6/1/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController {
    
    @IBOutlet weak var employeeName: UITextField!
    @IBOutlet weak var employeeNumber: UITextField!
    @IBOutlet weak var employeeDesignation: UITextField!
    @IBOutlet weak var employeeBand: UITextField!
    @IBOutlet weak var employeeProjectName: UITextField!
    weak var pickerView: UIPickerView?
    var selectedCompetency = Competency.iOS
    @IBOutlet weak var competencyTableView: UITableView!
    @IBOutlet weak var employeeNameErrorLabel: UILabel!
    @IBOutlet weak var employeeNumberErrorLabel: UILabel!
    @IBOutlet weak var employeeDesignationErrorLabel: UILabel!
    @IBOutlet weak var projectNameErrorLabel: UILabel!
    @IBOutlet weak var employeeBandErrorLabel: UILabel!
    let employeeViewModel = AddEmployeeViewModel()
    @IBOutlet weak var employeeAddScrollView: UIScrollView!
    var selectedEmployee: Employee? = Employee()
    
    
    @IBOutlet weak var employeeCompTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //allow tap on screen to remove text field input from screen
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        initiateView()
    }
    
    func initiateView() {
        // Do any additional setup after loading the view.
        self.title = "Add Employee"

        employeeViewModel.setAllDataForView()
        if((selectedEmployee?.employeeName) != nil){
            self.title = "Edit Employee"
            setupViewData()
        }
        employeeAddScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 650)
        let tempPickerView = UIPickerView()
        tempPickerView.dataSource = self
        tempPickerView.delegate = self
        employeeDesignation.inputView = tempPickerView
        employeeBand.inputView = tempPickerView
        employeeProjectName.inputView = tempPickerView
        self.pickerView = tempPickerView
    }
    
    func setupViewData() {
        employeeName.text = selectedEmployee?.employeeName
        employeeNumber.text = selectedEmployee?.employeeNumber
        employeeDesignation.text = selectedEmployee?.employeeDesignation
        selectedCompetency = Competency(rawValue: (selectedEmployee?.employeeComptency)!)!
        employeeProjectName.text = selectedEmployee?.employeeProject?.projectName
        employeeBand.text =  selectedEmployee?.employeeBand
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if(validateData()) {
            if(selectedEmployee != nil) {
                let employeeData = Employee()
                employeeData.employeeID = selectedEmployee?.employeeID as! String
                employeeData.employeeName = employeeName.text
                employeeData.employeeNumber = employeeNumber.text
                employeeData.employeeBand = employeeBand.text
                employeeData.employeeDesignation = employeeDesignation.text
                employeeData.employeeComptency = selectedCompetency.rawValue
                employeeViewModel.updateEmployeeData(employeeData: employeeData, projectName: employeeProjectName.text!, completion: {
                    self.navigationController!.popToRootViewController(animated: true)
                })
            } else {
                let employeeData = Employee()
                employeeData.employeeName = employeeName.text
                employeeData.employeeNumber = employeeNumber.text
                employeeData.employeeBand = employeeBand.text
                employeeData.employeeDesignation = employeeDesignation.text
                employeeData.employeeComptency = selectedCompetency.rawValue
                
                employeeViewModel.saveEmployeeData(employee: employeeData, projectName: employeeProjectName.text!) {
                    //self.displayErrorMessageWith(messageString: "Employee added successfully")
                    self.navigationController!.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    func validateData() -> Bool {
        var returnFlag = true
        do {
            try Validator.validateName(name: employeeName.text!)
            employeeNameErrorLabel.isHidden = true
        } catch Validator.InvalidNameError.errorMessage(message: let errorMSG) {
            returnFlag = false
            employeeNameErrorLabel.isHidden = false
            employeeNameErrorLabel.text = errorMSG
        } catch {
            employeeNameErrorLabel.text = error.localizedDescription
            employeeNameErrorLabel.isHidden = false
            returnFlag = false
        }
        do {
            try Validator.validateNumber(number: employeeNumber.text!)
            employeeNumberErrorLabel.isHidden = true
        } catch Validator.InvalidNameError.errorMessage(message: let errorMSG) {
            returnFlag = false
            employeeNumberErrorLabel.isHidden = false
            employeeNumberErrorLabel.text = errorMSG
        } catch {
            employeeNumberErrorLabel.text = error.localizedDescription
            employeeNumberErrorLabel.isHidden = false
            returnFlag = false
        }
        do {
            try Validator.validateNotEmpty(name: employeeProjectName.text!)
            projectNameErrorLabel.isHidden = true
        } catch Validator.InvalidNameError.errorMessage(message: let errorMSG) {
            returnFlag = false
            projectNameErrorLabel.isHidden = false
            projectNameErrorLabel.text = errorMSG
        } catch {
            projectNameErrorLabel.text = error.localizedDescription
            projectNameErrorLabel.isHidden = false
            returnFlag = false
        }
        do {
            try Validator.validateNotEmpty(name: employeeDesignation.text!)
            employeeDesignationErrorLabel.isHidden = true
        } catch Validator.InvalidNameError.errorMessage(message: let errorMSG) {
            returnFlag = false
            employeeDesignationErrorLabel.isHidden = false
            employeeDesignationErrorLabel.text = errorMSG
        } catch {
            employeeDesignationErrorLabel.text = error.localizedDescription
            employeeDesignationErrorLabel.isHidden = false
            returnFlag = false
        }
        do {
            try Validator.validateNotEmpty(name: employeeBand.text!)
            employeeBandErrorLabel.isHidden = true
        } catch Validator.InvalidNameError.errorMessage(message: let errorMSG) {
            returnFlag = false
            employeeBandErrorLabel.isHidden = false
            employeeBandErrorLabel.text = errorMSG
        } catch {
            employeeBandErrorLabel.text = error.localizedDescription
            employeeBandErrorLabel.isHidden = false
            returnFlag = false
        }
        return returnFlag
    }
    
    /// Method to dsiplay error messages on veiwcontroller
    ///
    /// - Parameter messageString: String to be used while displaying error message
    func displayErrorMessageWith(messageString:String) {
        let alert = UIAlertController(title: NSLocalizedString("ErrorHeader", comment: ""), message: messageString , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OkButton", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - UITextFieldDelegate

extension AddEmployeeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
}

// MARK: - UIPickerViewDelegate

extension AddEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if employeeDesignation.isFirstResponder {
            return employeeViewModel.employeeDesignations.count
        } else if employeeBand.isFirstResponder {
            return employeeViewModel.employeeBands.count
        } else {
            return employeeViewModel.projectsArray.count
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if employeeDesignation.isFirstResponder {
            return employeeViewModel.employeeDesignations[row].rawValue
        }  else if employeeBand.isFirstResponder {
            return employeeViewModel.employeeBands[row].rawValue
        } else {
            return employeeViewModel.projectsArray[row].projectName
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if employeeDesignation.isFirstResponder {
            employeeDesignation.text =  employeeViewModel.employeeDesignations[row].rawValue
        }  else if employeeBand.isFirstResponder {
            employeeBand.text = employeeViewModel.employeeBands[row].rawValue
        } else {
            employeeProjectName.text = employeeViewModel.projectsArray[row].projectName
        }
        self.view.endEditing(true)
    }
}

//MARK: - UITableView Delegate

extension AddEmployeeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeViewModel.employeeCompetencys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CompetencyTableViewCell
        cell.accessibilityIdentifier = "employeeCell_\(indexPath.row)"
        cell.textLabel?.text = employeeViewModel.employeeCompetencys[indexPath.row].rawValue
        if selectedCompetency == employeeViewModel.employeeCompetencys[indexPath.row] {
            cell.imageView?.image = UIImage(named: "radioSelect")
        } else {
            cell.imageView?.image = UIImage(named: "radio")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCompetency = employeeViewModel.employeeCompetencys[indexPath.row]
        employeeCompTableView.reloadData()
    }
    
}
