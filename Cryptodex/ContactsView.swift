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
    var screen = ScreenDimensions()

    init() {
        let viewOrigin = CGPoint(x: 0, y: screen.statusBarHeight + screen.headerHeight)
        let viewSize = CGSize(width: screen.width, height: screen.tableViewHeight)
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
        
        addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        setConstraint(to: table, from: self, on: .height, and: .height, mult: 1, constant: 0)
        setConstraint(to: table, from: self, on: .width, and: .width, mult: 1, constant: 0)
        setConstraint(to: table, from: self, on: .centerX, and: .centerX, mult: 1, constant: 0)
        setConstraint(to: table, from: self, on: .centerY, and: .centerY, mult: 1, constant: 0)
        
        table.register(ContactsCell.self, forCellReuseIdentifier: "ContactsCell")
        table.delegate = self
        table.dataSource = self
        
        table.backgroundColor = .lightGray
    }
 
    var headers = ["A","B","C",]
    
    var wallets = [
        ["A1234","A5678","A9012"],
        ["B3424","B5491","B6374"],
        ["C4444","C7338","C9828"],
    ]
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = headers[section]
        label.textColor = .white
        label.backgroundColor = .darkGray
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wallets.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ContactsCell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell") as! ContactsCell
        
        cell.cellLabel.text = wallets[indexPath.section][indexPath.row]
        
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
