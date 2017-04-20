//
//  SVNFormFieldDataSource.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 4/20/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTextValidator

public protocol SVNFormFieldDataSource {
    var placeholder: String { get set }
    var validationRule: [Rule] { get set }
}

struct EmailField: SVNFormFieldDataSource {
    var placeholder: String = "Email"
    var validationRule: [Rule] = [EmailRule(), RequiredRule()]
}
