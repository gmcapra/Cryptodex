//
//  headerView.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/10/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class headerView: UIView {
    
    var removeContact = UIButton()
    var addContact = UIButton()
    
    let appName = UILabel()

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        buildView()
    }
    
    func buildView() {
        
        for btn in [removeContact, addContact] {
            addSubview(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.backgroundColor = .lightGray
            setConstraint(to: btn, from: self, on: .height, and: .height, mult: 0, constant: 44)
            setConstraint(to: btn, from: self, on: .width, and: .width, mult: 0, constant: 44)
            setConstraint(to: btn, from: self, on: .top, and: .top, mult: 1, constant: 50)
        }
        setConstraint(to: removeContact, from: self, on: .leading, and: .leading, mult: 1, constant: 22)
        setConstraint(to: addContact, from: self, on: .trailing, and: .trailing, mult: 1, constant: -22)
        
        addSubview(appName)
        appName.translatesAutoresizingMaskIntoConstraints = false
        appName.text = "Cryptodex"
        appName.textColor = .lightGray
        appName.textAlignment = .center
        appName.font = UIFont.systemFont(ofSize: 40.0)
        //label.font = UIFont(name:"fontname", size: 20.0)
        setConstraint(to: appName, from: self, on: .height, and: .height, mult: 0, constant: 44)
        setConstraint(to: appName, from: self, on: .width, and: .width, mult: 0, constant: 200)
        setConstraint(to: appName, from: self, on: .centerX, and: .centerX, mult: 1, constant: 0)
        setConstraint(to: appName, from: self, on: .top, and: .top, mult: 1, constant: 50)

    }
    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
