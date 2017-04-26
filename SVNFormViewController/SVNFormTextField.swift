//
//  SVNFormTextField.swift
//  Tester
//
//  Created by Aaron Dean Bikis on 4/21/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNShapesManager

final class SVNFormTextField: UITextField {
    
    var type: FormFieldType! {
        didSet {
            self.keyboardType = type.dataSource.keyboardType
            self.isSecureTextEntry = type.dataSource.isSecureEntry()
            self.autocorrectionType = type.dataSource.hasAutoCorrection()
        }
    }
    
    var errorButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.tintColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
