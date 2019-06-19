//
//  QRScannedSummary.swift
//  Cryptodex
//
//  Created by Gianluca Capraro on 6/19/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import Foundation
import UIKit

class QRScannedSummary: UIView {
    
    //get screen dimensions
    let screen = ScreenDimensions()

    //define ui labels
    let verificationLabel = UILabel()
    let addressTypeLabel = UILabel()
    let addressIdentifierLabel = UILabel()
    
    
    init(walletType: String, walletAddress: String) {
        
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
        
        setupLabels(walletType:walletType,walletAddress:walletAddress)
        
    }
    
    func setupLabels(walletType: String, walletAddress: String) {
        
        // Define the label layout
            
        
        //Shows the type of cryptocurrency wallet that was scanned
        addressTypeLabel.backgroundColor = .clear
        addressTypeLabel.text = walletType
        addressTypeLabel.textColor = .lightGray
        addressTypeLabel.textAlignment = NSTextAlignment.center
        addressTypeLabel.font = UIFont(name: "Avenir-Light", size: 30)
        addressTypeLabel.contentMode = ContentMode.scaleAspectFit
        
        addSubview(addressTypeLabel)
        self.bringSubviewToFront(addressTypeLabel)
        
        //add constraints
        addressTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        addressTypeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        addressTypeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        addressTypeLabel.heightAnchor.constraint(equalToConstant: 500).isActive = true
        addressTypeLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        
        //Show the verification label
        verificationLabel.backgroundColor = .clear
        verificationLabel.text = "Please verify the address below before continuing:"
        verificationLabel.textColor = .white
        verificationLabel.textAlignment = NSTextAlignment.center
        verificationLabel.font = UIFont(name: "Avenir-Light", size: 20)
        verificationLabel.contentMode = ContentMode.scaleAspectFit
        verificationLabel.numberOfLines = 0
        
        addSubview(verificationLabel)
        self.bringSubviewToFront(verificationLabel)
        
        //add constraints
        verificationLabel.translatesAutoresizingMaskIntoConstraints = false
        verificationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        verificationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        verificationLabel.heightAnchor.constraint(equalToConstant: 500).isActive = true
        verificationLabel.centerYAnchor.constraint(equalTo: addressTypeLabel.centerYAnchor, constant: 100).isActive = true
        
        //Shows the exact address ID to be verified by user
        addressIdentifierLabel.backgroundColor = .clear
        addressIdentifierLabel.text = walletAddress
        addressIdentifierLabel.textColor = .lightGray
        addressIdentifierLabel.textAlignment = NSTextAlignment.center
        addressIdentifierLabel.font = UIFont(name: "Avenir-Light", size: 40)
        addressIdentifierLabel.numberOfLines = 0
        addressIdentifierLabel.contentMode = ContentMode.scaleAspectFit
        
        addSubview(addressIdentifierLabel)
        self.bringSubviewToFront(addressIdentifierLabel)
        
        //add constraints
        addressIdentifierLabel.translatesAutoresizingMaskIntoConstraints = false
        addressIdentifierLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        addressIdentifierLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        addressIdentifierLabel.heightAnchor.constraint(equalToConstant: 500).isActive = true
        addressIdentifierLabel.centerYAnchor.constraint(equalTo: verificationLabel.centerYAnchor, constant: 200).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
