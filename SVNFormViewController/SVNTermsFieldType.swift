//
//  SVNTermsFieldType.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/27/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNBootstraper

//public protocol SVNFormCheckMarkType {
//  var data: SVNFormTermsFieldDataSource { get }
//}

public protocol SVNFormCheckMarkViewModel {
  var terms: [String] { get }
  
  var checkMarkColor: UIColor { get }
  
  var font: UIFont { get }
  
  var textColor: UIColor { get }
  
  var finePrintParagraph: [FinePrintAttibutedString] { get }
  
   var finePrintAlignment: NSTextAlignment { get }
}
