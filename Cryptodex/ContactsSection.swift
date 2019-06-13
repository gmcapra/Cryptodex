//
//  ContactsHeader.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/13/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class ContactsSection: UIView {
    
    let label = UILabel()
    var screen: ScreenDimensions!

    override init(frame: CGRect) {
        super.init(frame: frame) 
        backgroundColor = .darkGray
    }
    
    func buildView(dimensions: ScreenDimensions) {
        screen = dimensions
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18.0)
        //label.font = UIFont(name:"fontname", size: 20.0)
        setConstraint(to: label, from: self, on: .height, and: .height, mult: 1, constant: 0)
        setConstraint(to: label, from: self, on: .width, and: .width, mult: 0, constant: screen.width-screen.statusBarHeight)
        setConstraint(to: label, from: self, on: .leading, and: .leading, mult: 1, constant:  screen.statusBarHeight/2)
        setConstraint(to: label, from: self, on: .centerY, and: .centerY, mult: 1, constant: 0)
        
    }
    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
}
