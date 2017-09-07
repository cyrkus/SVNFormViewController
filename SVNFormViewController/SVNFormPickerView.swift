//
//  FormPickerView.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 6/16/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

protocol SVNFormPickerViewDelegate: class {
  func formPicker(didSelectValue value:String)
}

class SVNFormPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
  
  var data: SVNFormPickerDataSource
  
  weak var formPickerDelegate: SVNFormPickerViewDelegate?
  
  
  init(frame: CGRect, data: SVNFormPickerDataSource) {
    self.data = data
    super.init(frame: frame)
    setUpPicker()
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  private func setUpPicker() {
    delegate = self
    dataSource = self
    let tgr = UITapGestureRecognizer(target: self, action: #selector(pickerTapped))
    addGestureRecognizer(tgr)
    tgr.delegate = self
  }
  
  func setMaxContent(toMax max: String){
    if let maxIndex = data.content.index(of: max) {
      data.content.removeSubrange(0..<maxIndex)
      self.reloadAllComponents()
    }
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    formPickerDelegate?.formPicker(didSelectValue: data.content[row])
  }
  
  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return frame.width
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var pickerLabel = view as? UILabel
    if pickerLabel == nil {
      pickerLabel = UILabel()
    }
    let frame = CGRect(x: pickerLabel!.frame.origin.x + 10,
                       y: pickerLabel!.frame.origin.y,
                       width: pickerLabel!.frame.width - 20, height: pickerLabel!.frame.height)
    pickerLabel?.frame = frame
    pickerLabel?.font = data.font
    pickerLabel?.adjustsFontSizeToFitWidth = true
    pickerLabel?.textAlignment = NSTextAlignment.center
    pickerLabel?.text = data.content[row]
    return pickerLabel!
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 65
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return data.content.count
  }
  
  func pickerTapped(_ sender: UITapGestureRecognizer){
    let rowHeight = self.rowSize(forComponent: 0).height
    let selectedRowFrame = self.bounds.insetBy(dx: 0.0, dy: (self.frame.height - rowHeight) / 2.0)
    let userTappedOnSelectedRow = selectedRowFrame.contains(sender.location(in: self))
    if userTappedOnSelectedRow {
      let value = data.content[selectedRow(inComponent: 0)]
      formPickerDelegate?.formPicker(didSelectValue: value)
    }
  }
}
