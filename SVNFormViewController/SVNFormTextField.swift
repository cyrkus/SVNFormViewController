//
//  SVNFormTextField.swift
//  Tester
//
//  Created by Aaron Dean Bikis on 4/21/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNBootstraper
import SVNMaterialButton
import SVNTheme


public protocol SVNFormTextFieldViewModel: class {
  var toolbarViewModel: SVNFormToolbarViewModel { get }
  var textFieldFont: UIFont { get }
  var textColor: UIColor { get }
  var type: SVNFormFieldType { get }
}

protocol SVNFormTextFieldDelegate: class {
  func forwardingToolbarStateChange(withState state: SVNFormToolbarState, sender: SVNFormTextField)
}

final class SVNFormTextField: UITextField, SVNFormField {
  
  weak var formDelegate: SVNFormTextFieldDelegate!
  
  var validationText: String {
    get {
      return text ?? ""
    }
  }
  
  class var StandardHeight: CGFloat {
    get {
      return SVNMaterialButton.standardHeight - SVNFormPlaceholderLabel.StandardHeight
    }
  }
  
  
  var isPristine: Bool = true
  
  var type: SVNFormFieldType!
  
  lazy var formToolbar: SVNFormToolBar = SVNFormToolBar(viewModel: self.viewModel.toolbarViewModel)
  
  var pickerView: SVNFormPickerView?
  
  var datePickerView: SVNFormDatePicker?
  
  private var viewModel: SVNFormTextFieldViewModel!
  
  func setView(withViewModel viewModel: SVNFormTextFieldViewModel, formDelegate: SVNFormTextFieldDelegate, textFieldDelegate: UITextFieldDelegate? = nil, autoFillText: String){
    isPristine = true
    self.type = viewModel.type
    self.formDelegate = formDelegate
    delegate = textFieldDelegate
    font = viewModel.textFieldFont
    textColor = viewModel.textColor
    keyboardType = type.fieldData.keyboardType
    isSecureTextEntry = type.fieldData.isSecureEntry
    autocorrectionType = type.fieldData.hasAutoCorrection
    
    text = autoFillText
    #if SVNFORM_shouldAutofill
      if autoFillText == "" {
        text = type.fieldData.stockData
      }
    #endif
    
    if let pickerData = type.fieldData.hasPickerView {
      pickerView = SVNFormPickerView(frame: CGRect.zero, data: pickerData.data)
      pickerView?.formPickerDelegate = self
      inputView = pickerView
    }
    
    if let datePickerType = type.fieldData.hasDatePicker {
      datePickerView = SVNFormDatePicker(frame: CGRect.zero, type: datePickerType.data)
      datePickerView?.delegate = self
      inputView = datePickerView
    }
    
    inputAccessoryView = formToolbar
    formToolbar.toolbarDelegate = self
  }



  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y,
                  width: bounds.width - 10, height: bounds.height)
  }
  
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y,
                  width: bounds.width - 10, height: bounds.height)
  }
}

extension SVNFormTextField: SVNFormToolBarDelegate {
  func onStateChange(state: SVNFormToolbarState) {
    formDelegate.forwardingToolbarStateChange(withState: state, sender: self)
  }
}

extension SVNFormTextField: SVNFormPickerViewDelegate {
  func formPicker(didSelectValue value: String) {
    text = value
  }
}

extension SVNFormTextField: SVNFormDatePickerDelegate {
  func datePicker(changedValue value: String) {
    text = value
  }
}
