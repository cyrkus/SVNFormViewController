//
//  SVNFormFieldView.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 8/9/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNBootstraper

public enum SVNFieldType {
  case toggle, textField, checkMark
}

protocol SVNFormFieldViewDelegate: class {
  func onCheckMarkLabelTap(withType type: SVNFormFieldType)
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
  
  var fieldData: SVNFormFieldType
  
  
  public init(textField data: SVNFormFieldType, delegate: UITextFieldDelegate, disclosureDelegate: SVNFormDisclosureButtonDelegate, autofillText: String, svnformDelegate: SVNFormTextFieldDelegate){
    self.fieldData = data
    super.init(frame: CGRect.zero)
    
    type = .textField
    textField.setView(for: data, formDelegate: svnformDelegate, textFieldDelegate: delegate, autoFillText:  autofillText)
    
    placeholder.setView(withViewModel: data.fieldData.placeholderViewModel, text: data.fieldData.placeholderText)
    placeholder.refreshView()
    
    addToolTip(for: data, disclosureDelegate: disclosureDelegate)
    
    setBorderStyling()
  }
  
  
  public init(checkMarkView data: SVNFormFieldType, autoFillText: String){
    self.fieldData = data
    super.init(frame: CGRect.zero)
    
    type = .checkMark
    
    checkMarkView.setView(asType: data, isChecked: autoFillText != "")
    
    guard let checkMarkViewModel = data.fieldData.isCheckMarkField else { return }
    
    termsLabel.attributedText = createFinePrintAttributedString(withParagraph: checkMarkViewModel.finePrintParagraph,
                                                                linkFont: checkMarkViewModel.finePrintFont, textColor: checkMarkViewModel.finePrintTextColor,
                                                                linkColor: checkMarkViewModel.finePrintLinkColor, alignment: checkMarkViewModel.finePrintAlignment)
    
    termsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTermsLabelTap)))
  }
  
  
  public init(toggleView data: SVNFormFieldType, autoFillText: String, disclosureDelegate: SVNFormDisclosureButtonDelegate){
    self.fieldData = data
    super.init(frame: CGRect.zero)
    type = .toggle
    
    toggleView.setView(withData: data.fieldData.hasToggle!, type: data, autofill: autoFillText)
    
    placeholder.setView(withViewModel: data.fieldData.placeholderViewModel,
                        text: data.fieldData.placeholderText)
    placeholder.refreshView()
    
    addToolTip(for: data, disclosureDelegate: disclosureDelegate)
  }
  
  
  private func addToolTip(for fieldType: SVNFormFieldType, disclosureDelegate: SVNFormDisclosureButtonDelegate){
    if let toolTipData = fieldType.fieldData.hasToolTip {
      toolTipView = SVNFormDisclosureButton(data: toolTipData.data, delegate: disclosureDelegate)
      addSubview(toolTipView!)
      
    } else if let datePickerImage = fieldType.fieldData.hasDatePicker?.detailDisclosureImage {
      toolTipView = SVNFormDisclosureButton(image: datePickerImage)
      addSubview(toolTipView!)
      
    } else if let pickerViewImage = fieldType.fieldData.hasPickerView?.detailDisclosureImage {
      toolTipView = SVNFormDisclosureButton(image: pickerViewImage)
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
    delegate.onCheckMarkLabelTap(withType: checkMarkView.type)
  }
  
  
  private func setBorderStyling(){
    layer.borderColor = fieldData.fieldBorderColor
    layer.borderWidth = fieldData.fieldBorderWidth
  }
}
