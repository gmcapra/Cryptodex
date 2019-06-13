//
//  QRScannerView.swift
//  CryptodexQRScanner
//
//  Created by Gianluca Capraro on 6/13/19.
//  Copyright © 2019 gmc. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class QRScannerView: UIView {
    
    let screen = ScreenDimensions()
    
    init() {
        
        let viewHeight = (3/4)*screen.width
        let viewWidth = (3/4)*screen.width
        let originX = screen.width/2 - viewWidth/2
        let originY = screen.height/2 - 2*viewHeight/3
        
        let viewOrigin = CGPoint(x: originX, y: originY)
        let viewSize = CGSize(width: viewWidth, height: viewHeight)
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
        
        backgroundColor = .black

        
    }
    
    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
