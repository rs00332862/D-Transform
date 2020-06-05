//
//  ProjectViewModel.swift
//  D-Transform
//
//  Created by Rohit on 5/20/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import RealmSwift

class ProjectViewModel {
    
    let realm = try! Realm()
    var projectArray: [Projects] = [Projects]()
    
    func saveProject(name: String, completion: @escaping () -> ()) {
        let newProject = Projects()
        newProject.projectName = name
        //newProject.projectID = String(getProjectListCount() + 1)
        try! realm.write {
            realm.add(newProject)
        }
        completion()
    }
    
    func getProjectListCount() -> Int {
        let result = realm.objects(Projects.self)
        return result.count
    }
    
    func getAllProject(completion: @escaping () -> ()) {
        let result = realm.objects(Projects.self)
        projectArray = [Projects]()
        for project in result {
            projectArray.append(project)
        }
        completion()
    }
    
    func deleteProjectName(projectID: String, completion: @escaping () -> ()) {
        let predicate = NSPredicate(format: "projectID == %@", projectID)
        try! realm.write {
            realm.delete(realm.objects(Projects.self).filter(predicate).first!)
            completion()
        }
    }
    
    func getAllProjectList() -> [Projects] {
        let result = realm.objects(Projects.self)
        projectArray = [Projects]()
        for project in result {
            projectArray.append(project)
        }
        return projectArray
    }
    
    func getProjectFrom(projectName: String) -> Projects {
        let result = realm.objects(Projects.self).filter("projectName = %@",projectName)
        return result.first!
    }
    
}
