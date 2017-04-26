//  SVNFormVC.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 4/20/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTheme
import SVNTextValidator
import SVNShapesManager

/**
 A View Controller containing a tableview set to the bounds of the viewController
 Intended to be set as a child of another View Controller.
 To initlize this VC call init(theme:, dataSource: nibNamed:, bundleNamed:)
 To validate textFields call validator.validate()
 Reference didValidateAllFields([FormFieldType: String]) as a callback to a sucessful validation
 Tapping Go on the return key type will attempt to validate the textFields resulting in didValidateAllFields being called if successful
 When resizing this viewController make sure to resize the tableview contained within it.
 */
open class SVNFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ValidationDelegate {
    
    public lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorColor = UIColor.clear
        self.view.addSubview(tv)
        return tv
    }()
    
    open var dataSource: [FormFieldType]!
    
    public lazy var validator = Validator()
    
    open var theme: SVNTheme
    
    open var didValidateAllFields: (([FormFieldType: String]) -> Void)!
    
    public var cellHeight: CGFloat = 65.0
    
    internal var textFields = [SVNFormTextField]()
    
    init(theme: SVNTheme, dataSource: [FormFieldType], nibNamed: String?, bundleNamed: Bundle?){
        self.theme = theme
        self.dataSource = dataSource
        super.init(nibName: nibNamed, bundle: bundleNamed)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.theme.backgroundColor
        self.tableView.backgroundColor = self.view.backgroundColor
        self.tableView.register(SVNFormTableViewCell.self,
                                forCellReuseIdentifier: SVNFormTableViewCell.reuseIdentifier)
    }
    
    
    //MARK: TableView DataSource
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Adds the sublayer if it hasn't been added before
        (cell as! SVNFormTableViewCell).seperator.strokeColor = UIColor.white.withAlphaComponent(0.6).cgColor
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SVNFormTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! SVNFormTableViewCell
        cell.backgroundColor = self.view.backgroundColor
        
        cell.setData(for: self.dataSource[indexPath.row],
                     font: self.theme.textField)
        
        validator.registerField(cell.textField,
                                rules: cell.textField.type.dataSource.validationRule)
        
        cell.textField.returnKeyType = indexPath.row == dataSource.count - 1
            ? UIReturnKeyType.go
            : UIReturnKeyType.next
        
        cell.textField.delegate = self
        self.textFields.append(cell.textField)
        return cell
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = textFields.index(of: textField as! SVNFormTextField) else { return true }
        
        if index == self.dataSource.count - 1{
            textField.resignFirstResponder()
            validator.validate(self)
            return true
        }
        let nextField = textFields[index + 1]
        nextField.becomeFirstResponder()
        return true
    }
    
    
    //MARK: Validation Delegate
    open func validationSuccessful() {
        var fields = [FormFieldType: String]()
        textFields.forEach({
            fields[$0.type] = $0.text ?? ""
        })
        self.didValidateAllFields(fields)
    }
    
    open func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        errors.forEach { (error) in
            let tf = error.0 as! SVNFormTextField
            addErrorButton(to: tf)
        }
    }
    
    func addErrorButton(to field: SVNFormTextField){
        var circleMeta = SVNShapeMetaData(shapes: nil,
                                          location: .midRight,
                                          padding: CGPoint(x: 0, y: 10),
                                          size: CGSize(width: field.frame.size.height - 20, height: field.frame.size.height - 20),
                                          fill: UIColor.clear.cgColor,
                                          stroke: UIColor.red.cgColor,
                                          strokeWidth: 1.5)
        
        let shapesManager = SVNShapesManager(container: field.frame)
        
        circleMeta.shapes = [shapesManager.createCircleLayer(with: circleMeta)]
        
        let button = UIButton(frame: shapesManager.fetchRect(with: circleMeta))
        field.errorButton = button
        field.addSubview(button)
        field.layer.addSublayer(circleMeta.shapes!.first!)
        
    }
}
