//
//  SVNFormPickerType.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 8/4/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import Foundation

public protocol SVNFormPickerType {
  var data: SVNFormPickerDataSource { get }
}


public protocol SVNFormPickerDataSource {
  var content: [String] { get set }
}
