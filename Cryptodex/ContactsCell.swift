//
//  ContactsCell.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/11/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    let appName = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .darkGray
        buildView()
    }
    
    func buildView() {
        
        addSubview(appName)
        appName.translatesAutoresizingMaskIntoConstraints = false
        appName.text = "lookatthisgreatwalletid"
        appName.textColor = .lightGray
        appName.textAlignment = .left
        appName.font = UIFont.systemFont(ofSize: 15.0)
        //label.font = UIFont(name:"fontname", size: 20.0)
        setConstraint(to: appName, from: self, on: .height, and: .height, mult: 0.8, constant: 0)
        setConstraint(to: appName, from: self, on: .width, and: .width, mult: 1, constant: -132)
        setConstraint(to: appName, from: self, on: .centerX, and: .centerX, mult: 1, constant: 0)
        setConstraint(to: appName, from: self, on: .centerY, and: .centerY, mult: 1, constant: 0)
        
    }
    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }

}
