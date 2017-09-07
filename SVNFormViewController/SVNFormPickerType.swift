//
//  SVNFormPickerType.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 8/4/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

public protocol SVNFormPickerType {
  /// The data source for the picker view
  var data: SVNFormPickerDataSource { get }
  
  /// the image to be displayed in the corresponding textfield as a detail disclosure
  var detailDisclosureImage: UIImage? { get }
}


public protocol SVNFormPickerDataSource {
  /// the content of the picker view
  var content: [String] { get set }
  
  var font: UIFont { get }
}
