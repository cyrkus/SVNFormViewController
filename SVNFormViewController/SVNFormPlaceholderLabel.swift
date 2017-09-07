//
//  SVNFormPlaceholderLabel.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 9/5/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNBootstraper

class SVNFormPlaceholderLabel: UILabel {
  
  private var standardText: String?
  
  class var StandardHeight: CGFloat {
    get {
      guard let device = UIDevice.whichDevice() else { return 15 }
      switch device {
      case .isIphone4, .isIphone5:
        return 15
      case .isIphone6:
        return 20
      default:
        return 25
      }
    }
  }
  
  var hasErrorMessage: String? {
    didSet {
      refreshView()
    }
  }
  
  var viewModel: SVNFormPlaceholderViewModel!
  
  func setView(withViewModel vm: SVNFormPlaceholderViewModel, text: String){
    standardText = text
    textAlignment = .left
    font = vm.font
    textColor = vm.textColor
  }
  
  
  func refreshView(){
    textColor = hasErrorMessage != nil ? viewModel.erroredTextColor : viewModel.textColor
    if hasErrorMessage == "Required" {
      guard let stockText = standardText else { return }
      if stockText.characters.last == "?" {
        text = stockText.substring(to: stockText.index(before: stockText.endIndex)).appending(" is Required")
      } else {
        text = "\(standardText!) is Required"
      }
      return
    }
    text = hasErrorMessage ?? standardText
  }
}
