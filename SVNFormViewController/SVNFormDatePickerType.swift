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
  /// the image to be displayed in the textfield
  var detailDisclosureImage: UIImage? { get }

}

public protocol SVNFormDatePickerDataSource {
  /// the UIDatePickerMode of the date picker 
  /// default is set to .date
  var datePickerMode: UIDatePickerMode { get }
  
  /// the date for the date picker to initially show
  /// default is set to the current Date()
  var startDate: Date { get }
}

public extension SVNFormDatePickerDataSource {
  
  var datePickerMode: UIDatePickerMode { return .date }
  
  var startDate: Date {
    let cal = Calendar(identifier: .gregorian)
    return cal.date(byAdding: DateComponents(), to: Date())!
  }
}
