//
//  ViewController.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/10/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let helloWorld = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        helloWorld.text = "Hello Cryptodex!"
        helloWorld.textColor = .lightGray
        view.addSubview(helloWorld)
    }

}

