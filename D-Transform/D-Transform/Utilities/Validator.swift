//
//  Validator.swift
//  Employee POC
//
//  Created by Rohit on 6/1/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
class Validator {
    
    enum InvalidNameError: Error {
        case errorMessage(message: String)
    }
    
    static func validateName(name: String) throws {
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        if (name.trimmingCharacters(in: .whitespaces) == ""){
            throw InvalidNameError.errorMessage(message: "Invalid Employee name, Please provide value for text field.")
        }
        let nameRegex = "^[a-zA-Z0-9_ ]*$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        if (!isValidateName) {
            throw InvalidNameError.errorMessage(message: "Invalid Employee name, Employee name should not contain any special characters")
        }
    }
    
    static func validateNumber(number: String) throws {
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        if (number.trimmingCharacters(in: .whitespaces) == ""){
            throw InvalidNameError.errorMessage(message: "Invalid Employee number, Please provide value for text field.")
        }
        if (number.count == 0 || number.count > 8){
            throw InvalidNameError.errorMessage(message: "Invalid Employee number, Employee number should have less than 8 digits")
        }
        let nameRegex = "^[0-9]*$"
        let trimmedString = number.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        if (!isValidateName) {
            throw InvalidNameError.errorMessage(message: "Invalid Employee number, Employee number should not contain whitespaces,  or special characters")
        }
    }
    
    static func validateNotEmpty(name: String) throws {
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        if (name.trimmingCharacters(in: .whitespaces) == ""){
            throw InvalidNameError.errorMessage(message: "Please provide value for text field.")
        }
    }
 
}
