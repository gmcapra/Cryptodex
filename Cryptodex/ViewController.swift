//
//  ViewController.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/10/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var header: HeaderView!
    var contacts: ContactsView!
    
    let screen = ScreenDimensions()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        header = HeaderView(dimensions: screen)
        let contactsOrigin = CGPoint(x: 0, y: screen.statusBarHeight + screen.headerHeight)
        let contactsSize = CGSize(width: screen.width, height: screen.tableViewHeight)
        contacts = ContactsView(frame: CGRect(origin: contactsOrigin, size: contactsSize), style: .plain)
        contacts.buildTable(dimensions: screen)
        view.addSubview(header)
        view.addSubview(contacts)
    }

}

