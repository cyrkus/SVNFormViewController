//
//  SVNFormFieldDataSource.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 4/20/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTextValidator

public protocol SVNFormFieldDataSource {
    var placeholder: String { get set }
    var validationRule: [Rule] { get set }
    var keyboardType: UIKeyboardType { get set }
    func hasAutoCorrection() -> UITextAutocorrectionType
    func isSecureEntry() -> Bool
}

extension SVNFormFieldDataSource {
    func hasAutoCorrection() -> UITextAutocorrectionType {
        return UITextAutocorrectionType.no
    }
    
    func isSecureEntry() -> Bool {
        return false
    }
}

public enum FormFieldType {
    case email, password, phoneNumber, address
    
    var dataSource: SVNFormFieldDataSource {
        switch self {
        case .email:
           return EmailField()
        case .password:
            return PasswordField()
        case .phoneNumber:
            return PhoneNumberField()
        case .address:
            return AddressField()
        }
    }
}

private struct EmailField: SVNFormFieldDataSource {
    var placeholder: String = "Email"
    var validationRule: [Rule] = [EmailRule(), RequiredRule()]
    var keyboardType: UIKeyboardType = UIKeyboardType.emailAddress
}

private struct PasswordField: SVNFormFieldDataSource {
    var placeholder: String = "Password"
    var validationRule: [Rule] = [RequiredRule()]
    var keyboardType: UIKeyboardType = UIKeyboardType.default
    
    func isSecureEntry() -> Bool {
        return true
    }
}

private struct PhoneNumberField: SVNFormFieldDataSource {
    var placeholder: String = "PhoneNumber"
    var validationRule: [Rule] = [RequiredRule()]
    var keyboardType: UIKeyboardType = UIKeyboardType.phonePad
}

private struct AddressField: SVNFormFieldDataSource {
    var placeholder: String = "Address"
    var validationRule: [Rule] = [RequiredRule()]
    var keyboardType: UIKeyboardType = UIKeyboardType.alphabet
}
