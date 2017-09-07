//
//  SVNFormPlaceHolderViewModel.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 9/7/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

/// The viewModel of the field's placeholder label 
/// - font: UIFont the font of the placeholder label
/// - textColor: UIColor the color of the placeholder's regular text
/// - erroredTextColor: UIColor the color of the placeholder's errored text
public protocol SVNFormPlaceholderViewModel {
  
  var font: UIFont { get }
  
  var textColor: UIColor { get }
  
  var erroredTextColor: UIColor { get }
}


