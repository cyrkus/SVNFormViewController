//
//  SVNFormOverlayViewModel.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 9/5/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import Foundation
import SVNMaterialButton

public protocol SVNFormTermsOverlayType {
  var data: SVNFormTermsOverlayDataSource { get }
}

public protocol SVNFormTermsOverlayDataSource {
  var body: [String] { get }
  var agreeText: String { get }
  var buttonData: SVNMaterialButtonViewModel? { get }
  var font: UIFont { get }
  var image: UIImage? { get }
}
