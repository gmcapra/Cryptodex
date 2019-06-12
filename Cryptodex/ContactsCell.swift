//
//  ContactsCell.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/11/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    let cellLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .lightGray
        buildView()
    }
    
    func buildView() {
        
        addSubview(cellLabel)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.text = "lookatthisgreatwalletid"
        cellLabel.textColor = .black
        cellLabel.textAlignment = .left
        cellLabel.font = UIFont.systemFont(ofSize: 15.0)
        //label.font = UIFont(name:"fontname", size: 20.0)
        setConstraint(to: cellLabel, from: self, on: .height, and: .height, mult: 0.8, constant: 0)
        setConstraint(to: cellLabel, from: self, on: .width, and: .width, mult: 1, constant: -132)
        setConstraint(to: cellLabel, from: self, on: .centerX, and: .centerX, mult: 1, constant: 0)
        setConstraint(to: cellLabel, from: self, on: .centerY, and: .centerY, mult: 1, constant: 0)
        
    }
    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }

}
