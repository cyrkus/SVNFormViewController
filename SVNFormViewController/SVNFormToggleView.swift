//
//  LWToggleView.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/22/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTextValidator
import SVNMaterialButton

protocol SVNFormToggleViewDelegate: class {
  func onToggleViewTap(withValidationText text: String)
}

class SVNFormToggleView: UIView, SVNFormField {
  
  var type: SVNFormFieldType!
  
  var validationText: String {
    return selectedTitle == nil ? "" : selectedTitle!
  }
  
  class var StandardHeight: CGFloat {
    get {
      return SVNMaterialButton.standardHeight
    }
  }
  
  class var PlaceHolderPadding: CGFloat {
    get {
      return 10
    }
  }
  
  weak var delegate: SVNFormToggleViewDelegate?
  
  var disclosureButton: SVNFormDisclosureButton?
  
  var selectedTitle: String?
  
  private var toggleType: SVNToggleType! {
    didSet {
      leftLabel.text = toggleType.data.titles.0
      rightLabel.text = toggleType.data.titles.1
    }
  }
  
  private lazy var leftLabel: UILabel = self.labelFactory()
  
  private lazy var rightLabel: UILabel = self.labelFactory()
  
  private func labelFactory() -> UILabel {
    let label = UILabel(frame: CGRect.zero)
    label.font = toggleType.data.font
    addSubview(label)
    label.isUserInteractionEnabled = true
    label.backgroundColor = toggleType.data.unselectedColor
    label.textColor = .white
    label.textAlignment = .center
    let tgr = UITapGestureRecognizer(target: self, action: #selector(didSelectToggle(_:)))
    label.addGestureRecognizer(tgr)
    return label
  }
  
  
  func setView(withData data: SVNToggleType, type: SVNFormFieldType, autofill: String?){
    self.type = type
    toggleType = data
    select(withTitle: autofill)
  }
  
  
  func didSelectToggle(_ sender: UITapGestureRecognizer){
    select(leftSide: sender.view == leftLabel)
  }
  
  private func unselectToggle(){
    selectedTitle = nil
    rightLabel.backgroundColor = toggleType.data.unselectedColor
    leftLabel.backgroundColor = toggleType.data.unselectedColor
  }
  
  
  private func select(leftSide: Bool){
    selectedTitle = leftSide ? toggleType.data.titles.0 : toggleType.data.titles.1
    rightLabel.backgroundColor = leftSide ? toggleType.data.unselectedColor :toggleType.data.selectedColor
    leftLabel.backgroundColor = leftSide ? toggleType.data.selectedColor : toggleType.data.unselectedColor
  }
  
  
  func select(withTitle title: String?){
    if title == "" || title == nil {
      unselectToggle()
      return
    }
    select(leftSide: title == toggleType.data.titles.0)
  }
  
  
  override func layoutSubviews() {
    
    leftLabel.frame = CGRect(x: 0, y: 0,
                             width: frame.width / 2 - 10, height: frame.height)
    
    rightLabel.frame = CGRect(x: frame.width / 2 + 10, y: 0,
                              width: frame.width / 2 - 10, height: frame.height)
    
    disclosureButton?.frame = CGRect(x: frame.width - 20, y: rightLabel.frame.origin.y - 25, width: 20, height: 20)
  }
}
