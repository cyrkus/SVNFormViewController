//
//  SVNToggleType.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/22/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

public protocol SVNToggleType {
  var data: SVNToggleDataSource { get }
}

public protocol SVNToggleDataSource {
  var titles: (String, String) { get }
  
  var font: UIFont { get }
  
  var selectedColor: UIColor { get }
  
  var unselectedColor: UIColor { get }
}

//extension SVNToggleDataSource {
//  var font: UIFont { return Theme.Fonts.textField.font }
//  
//  var selectedColor: UIColor { return  Theme.Colors.buttonColor.color }
//  
//  var unselectedColor: UIColor { return  Theme.Colors.buttonUnavailableColor.color }
//}
