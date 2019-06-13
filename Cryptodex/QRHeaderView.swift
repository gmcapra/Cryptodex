//
//  QRHeaderView.swift
//  CryptodexQRScanner
//
//  Created by Gianluca Capraro on 6/13/19.
//  Copyright © 2019 gmc. All rights reserved.
//

import Foundation
import UIKit

class QRHeaderView: UIView {
    
    let headerLabel = UILabel()
    let screen = ScreenDimensions()
    
    init() {
        
        let viewOrigin = CGPoint(x: 0, y: screen.statusBarHeight)
        let viewSize = CGSize(width: screen.width, height: screen.headerHeight)
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
        
        backgroundColor = .black
        buildView()
    }
    
    func buildView() {
    
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Cryptoscanner"
        headerLabel.textColor = .lightGray
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 30.0)
        setConstraint(to: headerLabel, from: self, on: .height, and: .height, mult: 0.8, constant: 0)
        setConstraint(to: headerLabel, from: self, on: .width, and: .width, mult: 1, constant: -132)
        setConstraint(to: headerLabel, from: self, on: .centerX, and: .centerX, mult: 1, constant: 0)
        setConstraint(to: headerLabel, from: self, on: .top, and: .top, mult: 1, constant: CGFloat(screen.headerHeight*0.1))
        
    }
    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
