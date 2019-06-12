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
      
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        header = HeaderView()
        contacts = ContactsView()
        view.addSubview(header)
        view.addSubview(contacts)
    }

}

