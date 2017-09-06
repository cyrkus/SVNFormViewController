//
//  SVNFormToolbarView.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 9/5/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTheme

public protocol SVNFormToolBarDelegate : class {
  func onStateChange(state: SVNFormToolbarState)
}

public enum SVNFormToolbarState {
  case dismiss, next, previous
}


public protocol SVNFormToolbarViewModel: class {
  var tintColor: UIColor { get }
  var upChevron: UIImage { get }
  var downChevron: UIImage { get }
}


class SVNFormToolBar: UIToolbar {
  
  weak var toolbarDelegate: SVNFormToolBarDelegate?
  
  private var viewModel: SVNFormToolbarViewModel
  
  init(frame: CGRect = CGRect.zero, viewModel: SVNFormToolbarViewModel){
    self.viewModel = viewModel
    
    super.init(frame: frame)
    barStyle = UIBarStyle.default
    isTranslucent = true
    tintColor = viewModel.tintColor
    sizeToFit()
    addButtons()
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  func addButtons(){
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolBarFinished))
    let firstFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let upButton = UIBarButtonItem(image: viewModel.upChevron, landscapeImagePhone: .none, style:.plain, target: self, action: #selector(previousField))
    let downButton = UIBarButtonItem(image: viewModel.downChevron, landscapeImagePhone: .none, style: .plain, target: self, action: #selector(nextField))
    setItems([doneButton, firstFlexibleSpace, upButton, downButton], animated: true)
    isUserInteractionEnabled = true
  }
  
  
  func previousField(){
    toolbarDelegate?.onStateChange(state: .previous)
  }
  
  
  func nextField(){
    toolbarDelegate?.onStateChange(state: .next)
  }
  
  
  func toolBarFinished(){
    toolbarDelegate?.onStateChange(state: .dismiss)
  }
}
