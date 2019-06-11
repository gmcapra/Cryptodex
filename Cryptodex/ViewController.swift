//
//  ViewController.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/10/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var header: headerView!
      
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        header = headerView()
        view.addSubview(header)
    }

}

