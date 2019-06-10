//
//  main.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/10/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class mainView: UIView {
    
    let helloWorld = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        helloWorld.text = "Cryptodex"
        helloWorld.textColor = .lightGray
        addSubview(helloWorld)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
