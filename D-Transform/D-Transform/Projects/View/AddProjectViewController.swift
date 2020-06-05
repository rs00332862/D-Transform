//
//  AddProjectViewController.swift
//  D-Transform
//
//  Created by Rohit on 5/20/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit


class AddProjectViewController: UIViewController {
    
    @IBOutlet weak var projectNameTextField: UITextField!
    var projectViewModel = ProjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("ADD_NEWPROJECT", comment: "")
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //projectNameTextField.becomeFirstResponder()
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        if (validateProjectName()) {
            projectViewModel.saveProject(name: projectNameTextField.text!){
                self.navigationController!.popToRootViewController(animated: true)
            }
        }
    }
    
    func validateProjectName() -> Bool {
        let projectName = projectNameTextField.text!
        var returnFlag = true
        do {
            try Validator.validateName(name: projectName)
        } catch Validator.InvalidNameError.errorMessage(message: let errorMSG) {
            self.displayErrorMessageWith(messageString: errorMSG)
            returnFlag = false
        } catch {
            self.displayErrorMessageWith(messageString: error.localizedDescription)
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
