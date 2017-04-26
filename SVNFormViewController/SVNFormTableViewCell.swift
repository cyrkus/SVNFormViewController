//
//  SVNFormTableViewCell.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 4/20/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

open class SVNFormTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        get {
            return "SVNFormTableViewCell"
        }
    }
    
    lazy var textField: SVNFormTextField = {
        let tf = SVNFormTextField(frame: CGRect(x: self.bounds.width / 8,
                                                y: 0,
                                                width: self.bounds.width - self.bounds.width / 4,
                                                height: self.bounds.height))
        self.addSubview(tf)
        return tf
    }()
    
    lazy var seperator: CAShapeLayer = {
        let seperator = CAShapeLayer()
        let path = UIBezierPath()
        path.lineWidth = 0.5
        path.move(to: CGPoint(x: 0, y: self.bounds.height / 2 - 20))
        path.addLine(to: CGPoint(x: self.textField.frame.size.width, y: self.bounds.height / 2 - 20))
        seperator.path = path.cgPath
        self.textField.layer.insertSublayer(seperator, at: 0)
        return seperator
    }()
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    open func setData(for textfieldType: FormFieldType, font: UIFont){
        self.textField.type = textfieldType
        let str = NSAttributedString(string: textfieldType.dataSource.placeholder,
                                     attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7),
                                                  NSFontAttributeName: font])
        self.textField.attributedPlaceholder = str
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not suported")
    }
}
