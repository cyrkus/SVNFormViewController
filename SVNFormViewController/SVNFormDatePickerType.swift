//
//  LWFormDatePickerDataSource.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/28/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

public protocol SVNFormDatePickerType {
  var data: SVNFormDatePickerDataSource { get }
}

public protocol SVNFormDatePickerDataSource {
  
  var datePickerMode: UIDatePickerMode { get }
  
  var minDate: Date { get }
}

public extension SVNFormDatePickerDataSource {
  
  var datePickerMode: UIDatePickerMode { return .date }
  
  var minDate: Date {
    let cal = Calendar(identifier: .gregorian)
    return cal.date(byAdding: DateComponents(), to: Date())!
  }
}
