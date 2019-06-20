//
//  ContactsView.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/11/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class ContactsView: UITableView {
    
//    var table = UITableView()
    var screen: ScreenDimensions!
    
    var test: Int {
        didSet {
            print("contacts test variable now: \(test)")
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        self.test = 0
        super.init(frame: frame, style: style)
    }
    
    func buildTable(dimensions: ScreenDimensions) {
        screen = dimensions
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray
    }
    
//    init(dimensions: ScreenDimensions) {
//        screen = dimensions
//        let viewOrigin = CGPoint(x: 0, y: screen.statusBarHeight + screen.headerHeight)
//        let viewSize = CGSize(width: screen.width, height: screen.tableViewHeight)
//        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
//
//        addSubview(table)
//        table.translatesAutoresizingMaskIntoConstraints = false
//        setConstraint(to: table, from: self, on: .height, and: .height, mult: 1, constant: 0)
//        setConstraint(to: table, from: self, on: .width, and: .width, mult: 1, constant: 0)
//        setConstraint(to: table, from: self, on: .centerX, and: .centerX, mult: 1, constant: 0)
//        setConstraint(to: table, from: self, on: .centerY, and: .centerY, mult: 1, constant: 0)
//
//        table.register(ContactsCell.self, forCellReuseIdentifier: "ContactsCell")
//        table.delegate = self
//        table.dataSource = self
//
//        table.backgroundColor = .lightGray
//    }
 
    var headers = ["A","B","C",]
    
    var wallets = [
        ["A1234","A5678","A9012","A1234","A5678","A9012"],
        ["B3424","B5491","B6374","B3424","B5491","B6374","B3424","B5491","B6374"],
        ["C4444","C7338","C9828","C4444","C7338","C9828","C4444","C7338","C9828"],
    ]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
