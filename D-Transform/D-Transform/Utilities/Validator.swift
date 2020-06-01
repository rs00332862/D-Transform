//
//  Validator.swift
//  Employee POC
//
//  Created by Rohit on 6/1/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
class Validator {
    static func validateName(name: String) ->Bool {
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        let nameRegex = "^[a-zA-Z0-9_ ]*$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
 
}
