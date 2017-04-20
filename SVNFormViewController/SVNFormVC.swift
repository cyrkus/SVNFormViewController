//
//  SVNFormVC.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 4/20/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTheme
/**
 A View Controller containing a tableview set to the bounds of the viewController
 Intended to be set as a child of another View Controller.
 To initlize this VC call init(theme:, nibNamed:, bundleNamed:)
 */

open class SVNFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds)
        self.view.addSubview(tv)
        return tv
    }()
    
    var dataSource: [SVNFormFieldDataSource]!
    
    open var theme: SVNTheme
    
    init(theme: SVNTheme, nibNamed:String, bundleNamed: Bundle?){
        self.theme = theme
        super.init(nibName: nibNamed, bundle: bundleNamed)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = [EmailField()]
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
}
