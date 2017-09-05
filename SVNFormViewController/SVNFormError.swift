//
//  SVNFormError.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 8/10/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import Foundation

enum SVNFormError: Error {
  case notTextFieldSubclass
  
  var localizedDescription: String {
    switch self {
    case .notTextFieldSubclass:
      return "unexpected UITextField subclass SVNform can only process SVNFormTextField"
    }
  }
}
