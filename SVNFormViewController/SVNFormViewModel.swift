//
//  SVNFormViewModel.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 8/4/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SwiftEssentials
import SVNTextValidator
import SVNTheme

protocol SVNFormViewModelDelegate: class {
  func formWasValidated()
  func formWasInvalid(error:[(Validatable, ValidationError)])
  func fieldWasValidated(field: SVNFormField)
}


/// The ViewModel of SVNFormViewController's tableview
/// To supply data to the ViewModel create a complete *SVNFormViewControllerDataSource*
class SVNFormViewModel: NSObject {
  
  //MARK: Delegates
  weak var delegate: SVNFormViewModelDelegate?
  
  fileprivate weak var textFieldDelegate: UITextFieldDelegate!
  
  fileprivate weak var disclosureButtonDelegate: SVNFormDisclosureButtonDelegate!
  
  fileprivate weak var formDelegate: SVNFormTextFieldDelegate!
  
  fileprivate weak var formFieldViewDelegate: SVNFormFieldViewDelegate!
  
  
  //MARK: Class variables
  class var TextFieldCellHeight: CGFloat {
    get {
      return SVNFormTextField.StandardHeight + SVNFormPlaceholderLabel.StandardHeight
    }
  }
  
  class var ToggleFieldCellHeight: CGFloat {
    get {
      return SVNFormToggleView.StandardHeight + SVNFormPlaceholderLabel.StandardHeight + SVNFormToggleView.PlaceHolderPadding
    }
  }
  
  class var CheckMarkFieldHeight: CGFloat {
    get {
      return SVNFormCheckMarkView.StandardHeight
    }
  }
  
  
  //MARK: Data
  var numberOfFields: Int {
    get {
      return dataSource.count
    }
  }
  
  fileprivate var dataSource: SVNFormViewControllerDataSource {
    didSet {
      validator.unregisterAllFields()
      autoFillText.removeAll()
    }
  }
  
  fileprivate lazy var autoFillText: [String] = {
    return Array(repeating: "", count: self.dataSource.count)
  }()
  
  fileprivate lazy var validator: Validator = Validator()
  
  
  init(dataSource: SVNFormViewControllerDataSource){
    self.dataSource = dataSource
    super.init()
  }
  
  func setDelegates(forTextField: UITextFieldDelegate, forDisclosureButton: SVNFormDisclosureButtonDelegate,
                    forSVNTextField: SVNFormTextFieldDelegate, forViewModel: SVNFormViewModelDelegate, forFieldView: SVNFormFieldViewDelegate){
    self.textFieldDelegate = forTextField
    self.disclosureButtonDelegate = forDisclosureButton
    self.formDelegate = forSVNTextField
    self.formFieldViewDelegate = forFieldView
    self.delegate = forViewModel
  }
  
  func getHeightForCell(atRow row: Int) -> CGFloat {
    let field = dataSource[row].fieldData
    if field.hasToggle != nil {
      return SVNFormViewModel.ToggleFieldCellHeight
    }
    
    if field.isCheckMarkField != nil {
      return SVNFormViewModel.CheckMarkFieldHeight
    }
    
    return SVNFormViewModel.TextFieldCellHeight
  }
  
  
  func update(dataSource: SVNFormViewControllerDataSource, autofillData: [String]? = nil){
    self.dataSource = dataSource
    setAutoFill(text: autofillData)
  }
  
  private func setAutoFill(text: [String]?){
    guard let autofill = text else { return }
    guard autofill.count == dataSource.count
      else { fatalError("must supply the same amount of autofill strings as datasource") }
    
    autoFillText = autofill
  }
}


extension SVNFormViewModel {
  func createField(forRow row: Int) -> SVNFormFieldView {
    let rowData = dataSource[row]
    
    if rowData.fieldData.hasToggle != nil {
      
      let toggleField = SVNFormFieldView(toggleView: rowData, autoFillText: autoFillText[row],
                                         disclosureDelegate: disclosureButtonDelegate)
      
      guard let rules = rowData.fieldData.validationRule else { return toggleField }
      
      validator.registerField(toggleField.toggleView, errorLabel: toggleField.placeholder,
                              rules: rules)
      
      return toggleField
    }
    
    
    if rowData.fieldData.isCheckMarkField  != nil {
      let checkMarkField = SVNFormFieldView(checkMarkView: rowData, autoFillText: autoFillText[row])
      
      checkMarkField.delegate = formFieldViewDelegate
      
      guard let rules = rowData.fieldData.validationRule else { return checkMarkField }
      
      validator.registerField(checkMarkField.checkMarkView, rules: rules)
      
      return checkMarkField
    }
    

    let textFormField = SVNFormFieldView(textField: rowData, delegate: textFieldDelegate,
                                         disclosureDelegate: disclosureButtonDelegate, autofillText: autoFillText[row],
                                         svnformDelegate: formDelegate)
    
    guard let rules = rowData.fieldData.validationRule else { return textFormField }
    
    validator.registerField(textFormField.textField, errorLabel: textFormField.placeholder,
                            rules: rules) 
    return textFormField
  }
}


extension SVNFormViewModel: ValidationDelegate {
  /// sets the style transformations for sucessful and errored validations
  func setStyleTransformers(success:((_ validationRule:ValidationRule)->Void)?,
                            error:((_ validationError:ValidationError)->Void)?) {
    validator.styleTransformers(success: success, error: error)
  }
  
  
  func validateForm(){
    validator.validate(self)
  }
  
  
  func validationSuccessful() {
    #if DEBUG_DEV || DEBUG_PROD
      print("validation Sucessful")
    #endif
    delegate?.formWasValidated()
  }
  
  
  func validationFailed(_ errors: [(Validatable, ValidationError)]) {
    delegate?.formWasInvalid(error: errors)
  }
  
  
  func validate(field: SVNFormField){
    validator.validateField(field) { (error) in
      guard error == nil else { return }
      delegate?.fieldWasValidated(field: field)
    }
  }
}
