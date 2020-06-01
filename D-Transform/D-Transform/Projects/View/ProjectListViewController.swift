//
//  ProjectListViewController.swift
//  D-Transform
//
//  Created by Rohit on 5/20/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import UIKit

class ProjectListViewController: UITableViewController {
    
    var projectViewModel = ProjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          fetchProjectData()
        self.title = NSLocalizedString("PROJECT_LIST", comment: "")
    }
    
    func fetchProjectData() {
        projectViewModel.getAllProject(){
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectViewModel.projectArray.count == 0 ? 1 : projectViewModel.projectArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.projectCellIdentifier, for: indexPath)
        if(projectViewModel.projectArray.count == 0) {
            cell.textLabel?.text = NSLocalizedString("NO_PROJECTDATA", comment: "")
        } else {
            cell.textLabel?.text = projectViewModel.projectArray[indexPath.row].projectName
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete
            projectViewModel.deleteProjectName(projectID: projectViewModel.projectArray[indexPath.row].projectID){
                DispatchQueue.main.async {
                    self.fetchProjectData()
                }
            }
        }
    }
    
}
