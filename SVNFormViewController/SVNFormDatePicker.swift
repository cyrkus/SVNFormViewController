//
//  LWDatePicker.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/16/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTheme

protocol SVNFormDatePickerDelegate: class {
  func datePicker(changedValue value:String)
}

class SVNFormDatePicker: UIDatePicker {
  
  weak var delegate: SVNFormDatePickerDelegate?
  
  var type: SVNFormDatePickerDataSource
  
  var dayOfWeekLabel : UILabel!
  
  var theme: SVNTheme
  
  init(frame: CGRect, type: SVNFormDatePickerDataSource, theme: SVNTheme) {
    self.type = type
    self.theme = theme
    super.init(frame: frame)
    setCalendar()
    setUpDatePicker()
    setDayOfWeekView()
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  private func setCalendar(){
    datePickerMode = type.datePickerMode
    setDate(type.startDate, animated: false)
  }
  
  
  private func setDayOfWeekView(){
    let width = UIWindow().bounds.width
    dayOfWeekLabel = UILabel(frame: CGRect(x: 0, y: frame.height - 25, width: width, height: 25))
    dayOfWeekLabel.backgroundColor = theme.stanardButtonTintColor
    dayOfWeekLabel.textColor = theme.primaryDialogColor
    dayOfWeekLabel.textAlignment = .center
    guard let dayOfWeek = getDayOfWeek() else { return }
    dayOfWeekLabel.text = dayOfWeek
    addSubview(dayOfWeekLabel)
  }
  
  
  private func getDayOfWeek() -> String? {
    let cal = Calendar(identifier: .gregorian)
    let dayOfWeek = cal.component(.weekday, from: date)
    switch dayOfWeek {
    case 1:
      return "Sunday"
    case 2:
      return "Monday"
    case 3:
      return "Tuesday"
    case 4:
      return "Wednesday"
    case 5:
      return "Thursday"
    case 6:
      return "Friday"
    case 7:
      return "Saturday"
    default:
      return nil
    }
  }
  
  
  private func setUpDatePicker(){
    addTarget(self, action:#selector(datePickerValueChanged), for: .valueChanged)
    setValue(theme.stanardButtonTintColor, forKey: "textColor")
  }
  
  
  func datePickerValueChanged(){
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "MM/dd/yyyy"
    let dateStr = dateFormater.string(from: date)
    delegate?.datePicker(changedValue: dateStr)
    guard let dayOfWeek = getDayOfWeek() else { return }
    dayOfWeekLabel.text = dayOfWeek
  }
}
