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

class QRScannerView: UIView, AVCaptureMetadataOutputObjectsDelegate {
    
    let screen = ScreenDimensions()
    
    //define ui labels and buttons
    let scanText = UILabel()
    var scanFrame: UIImageView!
    
    let testContactQR = ContactQRView(contactString: "COINDEXUNIQUE_CONTACT:tyrone:johnson:EOS:120932138214091212243:zcash:xgHRT78734jsrerwrewrwer")
    
    init() {
        
        //get headerview for reference
        let headerview = HeaderView(dimensions: screen)
        let heightDisplacement = headerview.frame.height/2
        
        let viewHeight = screen.height
        let viewWidth = screen.width
        let originX = screen.width/2 - viewWidth/2
        let originY = screen.height/2 - 2*viewHeight/5 + heightDisplacement
        
        let viewOrigin = CGPoint(x: originX, y: originY)
        let viewSize = CGSize(width: viewWidth, height: viewHeight)
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
        
        backgroundColor = .clear

        setupLabels()
        
        ////////CODE FOR TESTING THE CONTACTQRVIEW//////////////
        //testQRGenerator()

        
        
    }
    
    func testQRGenerator() {
        
        //shows generated qr code in place of scanner frame
        addSubview(testContactQR)
        self.bringSubviewToFront(testContactQR)
        testContactQR.contentMode = ContentMode.scaleAspectFit
        testContactQR.translatesAutoresizingMaskIntoConstraints = false
        testContactQR.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        testContactQR.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        testContactQR.heightAnchor.constraint(equalToConstant: 500).isActive = true
        testContactQR.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true

        
    }
    
    func setupLabels() {

        // Define the label layout

        //Show scanning label
        scanText.backgroundColor = .clear
        scanText.text = "Scanning for QR Code"
        scanText.textColor = .white
        scanText.textAlignment = NSTextAlignment.center
        scanText.font = UIFont(name: "Avenir-Light", size: 20)
        scanText.contentMode = ContentMode.scaleAspectFit

        // add button to view
        addSubview(scanText)
        self.bringSubviewToFront(scanText)

        //add constraints
        scanText.translatesAutoresizingMaskIntoConstraints = false
        scanText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        scanText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        scanText.heightAnchor.constraint(equalToConstant: 500).isActive = true
        scanText.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true

        //add the scanning frame image for reference
        scanFrame = UIImageView(image: UIImage(named: "scanFrame"))
        addSubview(scanFrame)
        self.bringSubviewToFront(scanFrame)


        //add constraints
        scanFrame.contentMode = ContentMode.scaleAspectFit
        scanFrame.translatesAutoresizingMaskIntoConstraints = false
        scanFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        scanFrame.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        scanFrame.heightAnchor.constraint(equalToConstant: 500).isActive = true
        scanFrame.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true

    }

    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
