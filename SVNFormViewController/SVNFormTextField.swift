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


public protocol SVNFormTextFieldDelegate: class {
  func forwardingToolbarStateChange(withState state: SVNFormToolbarState, sender: SVNFormTextField)
}

open class SVNFormTextField: UITextField, SVNFormField {
  
  weak var formDelegate: SVNFormTextFieldDelegate!
  
  public var validationText: String {
    get {
      return text ?? ""
    }
  }
  
  public class var StandardHeight: CGFloat {
    get {
      return SVNMaterialButton.standardHeight - SVNFormPlaceholderLabel.StandardHeight
    }
  }
  
  
  public var isPristine: Bool = true
  
  public var type: SVNFormFieldType!
  
  lazy var formToolbar: SVNFormToolBar = SVNFormToolBar()
  
  var pickerView: SVNFormPickerView?
  
  var datePickerView: SVNFormDatePicker?
  
  var theme: SVNTheme!
  
  
  public func setView(for type: SVNFormFieldType, formDelegate: SVNFormTextFieldDelegate, textFieldDelegate: UITextFieldDelegate? = nil, autoFillText: String, theme: SVNTheme){
    isPristine = true
    self.type = type
    self.formDelegate = formDelegate
    delegate = textFieldDelegate
    font = type.fieldData.textFieldFont
    textColor = type.fieldData.textColor
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
      pickerView = SVNFormPickerView(frame: CGRect.zero, data: pickerData.data, theme: theme)
      pickerView?.formPickerDelegate = self
      inputView = pickerView
    }
    
    if let datePickerType = type.fieldData.hasDatePicker {
      datePickerView = SVNFormDatePicker(frame: CGRect.zero, type: datePickerType.data, theme: theme)
      datePickerView?.delegate = self
      inputView = datePickerView
    }
    
    inputAccessoryView = formToolbar
    formToolbar.toolbarDelegate = self
    formToolbar.viewModel = type.fieldData.toolbarData
  }



  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y,
                  width: bounds.width - 10, height: bounds.height)
  }
  
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y,
                  width: bounds.width - 10, height: bounds.height)
  }
}

extension SVNFormTextField: SVNFormToolBarDelegate {
  public func onStateChange(state: SVNFormToolbarState) {
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
