//
//  Projects.swift
//  D-Transform
//
//  Created by Rohit on 5/20/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import RealmSwift

class Projects: Object {
    @objc dynamic var projectID = UUID().uuidString
    @objc dynamic var projectName: String?
    
    override static func primaryKey() -> String? {
      return "projectID"
    }
}
