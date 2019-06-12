//
//  ContactsView.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/11/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class ContactsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var table = UITableView()
    let screen = ScreenDimensions()

    init() {
        let viewOrigin = CGPoint(x: 0, y: screen.statusBarHeight + screen.headerHeight)
        let viewSize = CGSize(width: screen.width, height: screen.tableViewHeight)
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
        
        addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ContactsCell.self, forCellReuseIdentifier: "ContactsCell")
        setConstraint(to: table, from: self, on: .height, and: .height, mult: 1, constant: 0)
        setConstraint(to: table, from: self, on: .width, and: .width, mult: 1, constant: 0)
        setConstraint(to: table, from: self, on: .centerX, and: .centerX, mult: 1, constant: 0)
        setConstraint(to: table, from: self, on: .centerY, and: .centerY, mult: 1, constant: 0)
        table.backgroundColor = .darkGray
        table.delegate = self
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ContactsCell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell") as! ContactsCell
        return cell
    }
    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
