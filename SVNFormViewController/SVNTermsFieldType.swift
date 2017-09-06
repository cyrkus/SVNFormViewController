//
//  SVNTermsFieldType.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/27/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

public protocol SVNFormTermsFieldType {
  var data: SVNFormTermsFieldDataSource { get }
}

public protocol SVNFormTermsFieldDataSource {
  var terms: [String] { get }
  
  var checkMarkColor: UIColor { get }
  
  var font: UIFont { get }
  
  var textColor: UIColor { get }
}

extension SVNFormTermsFieldDataSource {
  var textColor: UIColor { return UIColor.darkGray }
  
  var checkMarkColor: UIColor { return UIColor.red }
}
