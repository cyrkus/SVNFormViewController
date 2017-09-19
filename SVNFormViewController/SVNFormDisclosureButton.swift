//
//  SVNFormDisclosureButton.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 7/24/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

public protocol SVNFormDisclosureButtonDelegate: class {
  func onDisclosureButtonTap(alertViewPresentationData data: SVNFormTermsOverlayDataSource?)
}


/// a detail disclosure icon to be placed in a formField
/// when init:LWTermsOverlayData it will enable the delegate to pass back valid data to present an alertOverlay with 
/// when init:image the delegate will pass back a LWTermsOverlayData of nil and thus the responder won't show an alertOverlay
class SVNFormDisclosureButton: UIView {
  weak var delegate: SVNFormDisclosureButtonDelegate?
  
  var dataSource: SVNFormTermsOverlayDataSource?
  
  class var StandardSize: CGFloat {
    get {
      return SVNFormPlaceholderLabel.StandardHeight
    }
  }
  
  private lazy var imageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "tooltip"))
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  
  init(data: SVNFormTermsOverlayDataSource, delegate: SVNFormDisclosureButtonDelegate){
    dataSource = data
    super.init(frame: CGRect.zero)
    self.delegate = delegate
    let tgr = UITapGestureRecognizer(target: self, action: #selector(onDisclosureTap))
    addGestureRecognizer(tgr)
    addSubview(imageView)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  init(image: UIImage){
    super.init(frame: CGRect.zero)
    imageView.image = image
    let tgr = UITapGestureRecognizer(target: self, action: #selector(onImageTap))
    addGestureRecognizer(tgr)
    addSubview(imageView)
  }
  
  
  @objc func onDisclosureTap(){
    delegate?.onDisclosureButtonTap(alertViewPresentationData: dataSource)
  }
  
  
  @objc func onImageTap(){
    if let formField = superview as? SVNFormFieldView {
      formField.textField.becomeFirstResponder()
    }
  }
  
  
  override func layoutSubviews() {
    imageView.frame = bounds
  }
}
