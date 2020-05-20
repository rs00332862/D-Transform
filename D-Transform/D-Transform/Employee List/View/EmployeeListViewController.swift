//
//  ViewController.swift
//  D-Transform
//
//  Created by Rohit on 5/19/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var employeeTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performInitialSetup()
    }

    /// perform initital set of activities as view controller is loaded
    ///
    /// Use this method to perform all intial activites as view controller is loaded like setting up UI and making service call
    private func performInitialSetup() {
        self.title = "Employee List"
        //self.addActivityIndicator()
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        employeeTableView.reloadData()
        //self.getEmployeeDataFromViewModel()
        self.setUpSearchViewController()
    }
    
    /// Method to setup search view controller on view controller
       func setUpSearchViewController() {
           searchController.searchResultsUpdater = self
           searchController.obscuresBackgroundDuringPresentation = false
           searchController.searchBar.placeholder = NSLocalizedString("SearchTextFieldPlaceHolderText", comment: "")
           navigationItem.searchController = searchController
           // navigationBar.navigationItem.searchController = searchController
           definesPresentationContext = true
       }

}

//MARK: - UISearchBar Delegate
extension EmployeeListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
    }
}

extension EmployeeListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.employeeCustomCellIdentifier) as! EmployeeCell
        cell.tag = indexPath.row
        cell.employeeName.text = "Rohit Shivankar(U4)"
        cell.employeeNumber.text = "332862"
        cell.employeeProject.text = "Internal"
        cell.employeeCompetency.text = "iOS"
        cell.employeeDesignation.text = "Tech Lead"
        cell.employeeImage.image = UIImage.init(named: "iOS")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete
            //print("Delete method called")
            
        }
    }
}