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
    let employeeListViewModel = EmployeeListViewModel()
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        performInitialSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = "Back"
    }
    
    /// perform initital set of activities as view controller is loaded
    ///
    /// Use this method to perform all intial activites as view controller is loaded like setting up UI and making service call
    private func performInitialSetup() {
        self.title = "Employee List"
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        self.setUpSearchViewController()
        getEmployeeDataFromViewModel()
        
    }
    
    func getEmployeeDataFromViewModel() {
        employeeListViewModel.getAllEmployeeData {
            self.employeeTableView.reloadData()
        }
    }
    
    /// Method to setup search view controller on view controller
    func setUpSearchViewController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("SearchTextFieldPlaceHolderText", comment: "")
        self.employeeTableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    
    
}

//MARK: - UISearchBar Delegate
extension EmployeeListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        employeeListViewModel.filterEmployeeDataWith(string: searchBar.text!) {
            self.employeeTableView.reloadData()
        }
    }
}

extension EmployeeListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeListViewModel.getEmployeeListCount(isFiltrig: isFiltering)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.employeeCustomCellIdentifier) as! EmployeeCell
        cell.setUpCellData(employeeData: employeeListViewModel.getEmployeeData(indexPathRow: indexPath.row, isFiltrig: isFiltering))
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
