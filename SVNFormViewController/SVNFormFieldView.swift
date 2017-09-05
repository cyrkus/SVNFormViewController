//
//  SVNFormFieldView.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 8/9/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

public enum SVNFieldType {
  case toggle, textField, checkMark
}

protocol SVNFormFieldViewDelegate: class {
  func onCheckMarkLabelTap()
}

public class SVNFormFieldView: UIView, FinePrintCreatable {
  
  weak var delegate: SVNFormFieldViewDelegate!
  
  var yPadding: CGFloat {
    get {
      return 10.0
    }
  }
  
  lazy var textField: SVNFormTextField = {
    let tf = SVNFormTextField()
    self.addSubview(tf)
    return tf
  }()
  
  lazy var checkMarkView: SVNFormCheckMarkView = {
    let check = SVNFormCheckMarkView()
    check.checkMarkColor = Theme.Colors.buttonColor.color
    self.addSubview(check)
    return check
  }()
  
  lazy var toggleView: SVNFormToggleView = {
    let toggle = SVNFormToggleView()
    self.addSubview(toggle)
    return toggle
  }()
  
  lazy var placeholder: SVNFormPlaceholderLabel = {
    let label = SVNFormPlaceholderLabel()
    self.addSubview(label)
    return label
  }()
  
  private lazy var termsLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .left
    label.isUserInteractionEnabled = true
    self.addSubview(label)
    return label
  }()
  
  var toolTipView: SVNFormDisclosureButton?
  
  var type: SVNFieldType!
  
  init(withTextFieldData data: SVNFormFieldType, delegate: UITextFieldDelegate, disclosureDelegate: SVNFormDisclosureButtonDelegate, autofillText: String, svnformDelegate: SVNFormTextFieldDelegate){
    super.init(frame: CGRect.zero)
    type = .textField
    textField.setView(forType: data, formDelegate: svnformDelegate, textFieldDelegate: delegate, autoFillText:  autofillText)
    
    placeholder.standardText = data.fieldData.placeholder
    placeholder.refreshView()
    
    addToolTip(for: data, disclosureDelegate: disclosureDelegate)
    
    setBorderStyling()
  }
  
  
  init(withCheckMarkData fieldType: SVNFormFieldType, autoFillText: String){
    super.init(frame: CGRect.zero)
    type = .checkMark
    checkMarkView.setView(asType: fieldType, isChecked: autoFillText != "")
    termsLabel.attributedText = createFinePrintAttributedString(withStrings: fieldType.fieldData.isTerms!.data.terms,
                                                                linkFont: Theme.Fonts.finePrintSM.font,
                                                                textColor: Theme.Colors.darkText.color,
                                                                linkColor: Theme.Colors.buttonColor.color, alignment: .left)
    termsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTermsLabelTap)))
  }
  
  
  init(fieldType: SVNFormFieldType, autoFillText: String, placeholderText: String, disclosureDelegate: SVNFormDisclosureButtonDelegate){
    super.init(frame: CGRect.zero)
    type = .toggle
    
    toggleView.setView(withData: fieldType.fieldData.hasToggle!, type: fieldType, autofill: autoFillText)
    
    placeholder.standardText = placeholderText
    placeholder.refreshView()
    
    addToolTip(for: fieldType, disclosureDelegate: disclosureDelegate)
  }
  
  
  private func addToolTip(for fieldType: SVNFormFieldType, disclosureDelegate: SVNFormDisclosureButtonDelegate){
    if let toolTipData = fieldType.fieldData.hasToolTip {
      toolTipView = SVNFormDisclosureButton(data: toolTipData.data, delegate: disclosureDelegate)
      addSubview(toolTipView!)
      
    } else if fieldType.fieldData.hasDatePicker != nil {
      toolTipView = SVNFormDisclosureButton(image: #imageLiteral(resourceName: "calendarIcon"))
      addSubview(toolTipView!)
      
    } else if fieldType.fieldData.hasPickerView != nil {
      toolTipView = SVNFormDisclosureButton(image: #imageLiteral(resourceName: "fa-caret-down"))
      addSubview(toolTipView!)
    }
  }
  
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override public func layoutSubviews() {
    switch type! {
    case .textField:
      placeholder.frame = CGRect(x: yPadding / 2, y: yPadding / 2,
                                 width: frame.width - yPadding, height: SVNFormPlaceholderLabel.StandardHeight)
      
      let tfY = placeholder.frame.origin.y + placeholder.frame.height
      
      textField.frame = CGRect(x: yPadding / 2, y: tfY,
                               width: frame.width - yPadding, height: SVNFormTextField.StandardHeight)
      
      toolTipView?.frame = CGRect(x: frame.width - 35, y: frame.height / 2 - SVNFormDisclosureButton.StandardSize / 2,
                                  width: SVNFormDisclosureButton.StandardSize, height: SVNFormDisclosureButton.StandardSize)
      
    case .toggle:
      placeholder.frame = CGRect(x: 0, y: 0,
                                 width: frame.width - 55, height: SVNFormPlaceholderLabel.StandardHeight)
      
      toggleView.frame = CGRect(x: 0, y: placeholder.frame.origin.y + placeholder.frame.size.height + SVNFormToggleView.PlaceHolderPadding,
                                width: frame.width, height: SVNFormToggleView.StandardHeight)
      
      toolTipView?.frame = CGRect(x: frame.width - 35, y: (SVNFormPlaceholderLabel.StandardHeight - SVNFormDisclosureButton.StandardSize) / 2,
                                  width: SVNFormDisclosureButton.StandardSize, height: SVNFormDisclosureButton.StandardSize)
      
    case .checkMark:
      let checkMarkContainerWidth = frame.height / 1.5
      
      checkMarkView.frame = CGRect(x: 0, y: frame.height / 2  - checkMarkContainerWidth / 2,
                                   width: checkMarkContainerWidth, height: checkMarkContainerWidth)
      
      let x = checkMarkView.frame.origin.x + checkMarkView.frame.size.width + 10
      
      termsLabel.frame = CGRect(x: x, y: 0,
                                width: frame.width - x, height: frame.height)
    }
  }
  
  @objc private func onTermsLabelTap(){
    delegate.onCheckMarkLabelTap()
  }
  
  private func setBorderStyling(){
    layer.borderColor = Theme.Colors.lightText.color.cgColor
    layer.borderWidth = 0.5
  }
}
