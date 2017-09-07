//
//  SVNFormToolbarView.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 9/5/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

public protocol SVNFormToolBarDelegate : class {
  func onStateChange(state: SVNFormToolbarState)
}

public enum SVNFormToolbarState {
  case dismiss, next, previous
}


class SVNFormToolBar: UIToolbar {
  
  weak var toolbarDelegate: SVNFormToolBarDelegate?
  
  var viewModel: SVNFormToolbarViewModel! {
    didSet {
      addButtons()
      tintColor = viewModel.tintColor
    }
  }
  
  override init(frame: CGRect = CGRect.zero){
    super.init(frame: frame)
    barStyle = UIBarStyle.default
    isTranslucent = true
    sizeToFit()
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  private func addButtons(){
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarFinished))
    let firstFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let upButton = UIBarButtonItem(image: viewModel.upChevron, landscapeImagePhone: .none, style:.plain, target: self, action: #selector(previousField))
    let downButton = UIBarButtonItem(image: viewModel.downChevron, landscapeImagePhone: .none, style: .plain, target: self, action: #selector(nextField))
    setItems([doneButton, firstFlexibleSpace, upButton, downButton], animated: true)
    isUserInteractionEnabled = true
  }
  
  
  @objc
  private func previousField(){
    toolbarDelegate?.onStateChange(state: .previous)
  }
  
  @objc
  private func nextField(){
    toolbarDelegate?.onStateChange(state: .next)
  }
  
  @objc
  private func toolBarFinished(){
    toolbarDelegate?.onStateChange(state: .dismiss)
  }
}
