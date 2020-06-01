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
        let projectName = projectNameTextField.text!
        if (projectName != "" && Validator.validateName(name: projectNameTextField.text!)) {
            projectViewModel.saveProject(name: projectNameTextField.text!){
                self.navigationController!.popToRootViewController(animated: true)
            }
        }else {
            self.displayErrorMessageWith(messageString: NSLocalizedString("ADD_PROJECTERROR", comment: ""))
        }
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
