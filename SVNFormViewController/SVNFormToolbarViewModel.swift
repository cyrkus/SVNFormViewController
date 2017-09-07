//
//  SVNFormToolbarViewModel.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 9/6/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
/// the ui attributes of the toolbar that sits above the textField 
/// - tintColor: UIColor the tint color of the buttons
/// - upChevron: UIImage the toggle up image
/// - downChevron: UIImage the toggle down chevron
public protocol SVNFormToolbarViewModel {
  var tintColor: UIColor { get }
  var upChevron: UIImage { get }
  var downChevron: UIImage { get }
}
