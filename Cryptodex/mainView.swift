//
//  main.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/10/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class mainView: UIView {
    
    var header: headerView!

    override init(frame: CGRect) {
        super.init(frame:frame)

        header = headerView(frame:frame)
        addSubview(header)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
