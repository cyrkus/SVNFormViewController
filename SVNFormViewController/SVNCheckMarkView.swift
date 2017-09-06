//
//  LWCheckMarkView.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 7/6/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNShapesManager
import SVNTextValidator
import SVNBootstraper
import SVNTheme


class SVNFormCheckMarkView: UIView, SVNFormField {
  
  class var StandardHeight: CGFloat {
    get {
      guard let device = UIDevice.whichDevice() else { return 55.0 }
      switch device {
      case .isIphone4, .isIphone5:
        return 55.0
      case .isIphone6:
        return 95.0
      default:
        return 100.0
      }
    }
  }
  
  var validationText: String {
    get {
      return isChecked ? "tapped" : ""
    }
  }
  
  var isChecked: Bool = false {
    didSet {
      selectCheckMark()
    }
  }
  
  var type: SVNFormFieldType!
  
  fileprivate var theme: SVNTheme {
    didSet {
      checkmarkMeta.stroke = theme.acceptButtonTintColor.cgColor
    }
  }
  
  var hasErrorMessage: String {
    didSet {
      animateError(isError: hasErrorMessage != "")
    }
  }
  
  private lazy var checkmarkMeta: SVNShapeMetaData = self.checkmarkMetaFactory()
  
  private func checkmarkMetaFactory() -> SVNShapeMetaData {
    return SVNShapeMetaData(shapes: nil,
                            location: .fullRect,
                            padding: CGPoint(x: 2.5, y: 5),
                            size: CGSize(width: 0, height: 0),
                            fill: UIColor.clear.cgColor,
                            stroke: UIColor.red.cgColor,
                            strokeWidth: 5.0)
  }
  
  
  init(theme: SVNTheme){
    self.theme = theme
    hasErrorMessage = ""
    super.init(frame: CGRect.zero)
    setupContainer()
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  override func layoutSubviews() {
    if isChecked {
      createCheckMark()
    }
  }
  
  
  func setView(asType type: SVNFormFieldType, isChecked: Bool){
    self.type = type
    self.isChecked = isChecked
  }
  
  private func setupContainer() {
    backgroundColor = .clear
    layer.borderColor = theme.navigationBarColor.cgColor
    layer.borderWidth = 0.5
    let tgr = UITapGestureRecognizer(target: self, action: #selector(didTapContainer))
    addGestureRecognizer(tgr)
  }
  
  
  func animateError(isError: Bool){
    let fromWidth = layer.borderWidth
    let toWidth: CGFloat = isError ? 5.0 : 0.5
    let toColor: CGColor = isError ? theme.declineButtonTintColor.cgColor : theme.acceptButtonTintColor.cgColor
    CATransaction.begin()
    let colorAnim = CABasicAnimation(keyPath: "borderColor")
    colorAnim.duration = 0.25
    colorAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    colorAnim.fromValue = layer.borderColor
    colorAnim.toValue = toColor
    
    let widthAnim = CABasicAnimation(keyPath: "borderWidth")
    widthAnim.fromValue = fromWidth
    widthAnim.toValue = toWidth
    widthAnim.timingFunction = colorAnim.timingFunction
    widthAnim.duration = 0.5
    
    layer.add(widthAnim, forKey: "widthAnim")
    layer.add(colorAnim, forKey: "colorAnim")
    
    CATransaction.setCompletionBlock {
      self.layer.borderWidth = toWidth
      self.layer.borderColor = toColor
    }
    CATransaction.commit()
  }
  
  
  @objc private func didTapContainer(){
    isChecked = !isChecked
    selectCheckMark()
  }
  
  
  private func selectCheckMark(){
    if isChecked {
      hasErrorMessage = ""
      createCheckMark()
      return
    }
    
    checkmarkMeta.shapes?.forEach({
      $0.removeFromSuperlayer()
    })
    checkmarkMeta.shapes = nil
  }
  
  
  private func createCheckMark(){
    
    checkmarkMeta.shapes?.forEach({ $0.removeFromSuperlayer() }) // remove them if they exist before adding them again as this is called when laying out subviews
    checkmarkMeta.shapes = nil
    
    let manager =  SVNShapesManager(container: frame)
    checkmarkMeta.shapes = [manager.createCheckMark(with: checkmarkMeta)]
    checkmarkMeta.shapes?.forEach({
      self.layer.addSublayer($0)
    })
  }
}

