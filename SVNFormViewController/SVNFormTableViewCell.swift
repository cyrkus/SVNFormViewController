//
//  SVNFormTableViewCell.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 4/20/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

open class SVNFormTableViewCell: UITableViewCell {
    
    open var dataSource: SVNFormFieldDataSource!
    
    class var reuseIdentifier: String {
        get {
            return "SVNFormTableViewCell"
        }
    }
    
    lazy var textField: UITextField = {
        let tf = UITextField(frame: self.bounds)
        return tf
    }()
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    open func set(dataSource: SVNFormFieldDataSource, font: UIFont){
        self.dataSource = dataSource
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not suported")
    }
    
    
}
