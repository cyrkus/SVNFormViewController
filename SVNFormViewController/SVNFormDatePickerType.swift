//
//  LWFormDatePickerDataSource.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/28/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

protocol SVNFormDatePickerType {
  var data: SVNFormDatePickerDataSource { get }
}

protocol SVNFormDatePickerDataSource {
  
  var datePickerMode: UIDatePickerMode { get }
  
  var minDate: Date { get }
}

extension SVNFormDatePickerDataSource {
  
  var datePickerMode: UIDatePickerMode { return .date }
  
  var minDate: Date {
    let cal = Calendar(identifier: .gregorian)
    return cal.date(byAdding: DateComponents(), to: Date())!
  }
}
