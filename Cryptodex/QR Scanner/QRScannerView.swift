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
    
    let scanSuccessLabel = UILabel()
    let verificationLabel = UILabel()
    let addressTypeLabel = UILabel()
    let addressIdentifierLabel = UILabel()
    
    let flashButton = UIButton()
    let cancelButton = UIButton()
    let scanAnotherButton = UIButton()
    
    //keep track of flash
    var flashOn: Bool!
    
    
    init() {
        
        let viewHeight = screen.height
        let viewWidth = screen.width
        let originX = screen.width/2 - viewWidth/2
        let originY = screen.height/2 - 2*viewHeight/5
        
        let viewOrigin = CGPoint(x: originX, y: originY)
        let viewSize = CGSize(width: viewWidth, height: viewHeight)
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
        
        backgroundColor = .clear

        setupLabels()
        setupButtons()
        
    }
    
    
    func setupButtons() {
        
        
        //add the flash button to the view
        flashButton.setBackgroundImage(UIImage(named: "flashOFF"), for: .normal)
        flashButton.isEnabled = true
        flashButton.isHidden = false
        addSubview(flashButton)
        
        //add button action for flash
        flashButton.addTarget(self, action: #selector(flashTapped), for: .touchUpInside)
        flashOn = false
        
        //add constraints
        flashButton.translatesAutoresizingMaskIntoConstraints = false
        flashButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        flashButton.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -150).isActive = true
        
        
    }
    
    func setupLabels() {
        
        // Define the label layout
        
        
        //Show scanning label
        scanText.backgroundColor = .clear
        scanText.text = "Scanning for QR Code"
        scanText.textColor = .white
        scanText.textAlignment = NSTextAlignment.center
        scanText.font = UIFont(name: "Helvetica", size: 20)
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
        
        
        //Create placeholders for the summary information
        
        scanSuccessLabel.backgroundColor = .clear
        scanSuccessLabel.text = ""
        scanSuccessLabel.textColor = .green
        scanSuccessLabel.textAlignment = NSTextAlignment.center
        scanSuccessLabel.font = UIFont(name: "Helvetica", size: 15)
        scanSuccessLabel.contentMode = ContentMode.scaleAspectFit
        
        addSubview(scanSuccessLabel)
        self.bringSubviewToFront(scanSuccessLabel)
        
        //add constraints
        scanSuccessLabel.translatesAutoresizingMaskIntoConstraints = false
        scanSuccessLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        scanSuccessLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        scanSuccessLabel.heightAnchor.constraint(equalToConstant: 500).isActive = true
        scanSuccessLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        //Shows the type of cryptocurrency wallet that was scanned
        addressTypeLabel.backgroundColor = .clear
        addressTypeLabel.text = ""
        addressTypeLabel.textColor = .lightGray
        addressTypeLabel.textAlignment = NSTextAlignment.center
        addressTypeLabel.font = UIFont(name: "Helvetica", size: 45)
        addressTypeLabel.contentMode = ContentMode.scaleAspectFit
        
        addSubview(addressTypeLabel)
        self.bringSubviewToFront(addressTypeLabel)
        
        //add constraints
        addressTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        addressTypeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        addressTypeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        addressTypeLabel.heightAnchor.constraint(equalToConstant: 500).isActive = true
        addressTypeLabel.centerYAnchor.constraint(equalTo: scanSuccessLabel.centerYAnchor, constant: 100).isActive = true
        
        //Show the verification label
        verificationLabel.backgroundColor = .clear
        verificationLabel.text = ""
        verificationLabel.textColor = .white
        verificationLabel.textAlignment = NSTextAlignment.center
        verificationLabel.font = UIFont(name: "Helvetica", size: 20)
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
        addressIdentifierLabel.text = ""
        addressIdentifierLabel.textColor = .lightGray
        addressIdentifierLabel.textAlignment = NSTextAlignment.center
        addressIdentifierLabel.font = UIFont(name: "Helvetica", size: 40)
        addressIdentifierLabel.numberOfLines = 0
        addressIdentifierLabel.contentMode = ContentMode.scaleAspectFit
        
        addSubview(addressIdentifierLabel)
        self.bringSubviewToFront(addressIdentifierLabel)
        
        //add constraints
        addressIdentifierLabel.translatesAutoresizingMaskIntoConstraints = false
        addressIdentifierLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        addressIdentifierLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        addressIdentifierLabel.heightAnchor.constraint(equalToConstant: 500).isActive = true
        addressIdentifierLabel.centerYAnchor.constraint(equalTo: verificationLabel.centerYAnchor, constant: 150).isActive = true
        
    }
    
    
    @objc func flashTapped() {
        
        if flashOn == false {
            toggleFlash(on: true)
            flashButton.setBackgroundImage(UIImage(named: "flashON"), for: .normal)
            flashOn = true
            
        } else {
            toggleFlash(on: false)
            flashButton.setBackgroundImage(UIImage(named: "flashOFF"), for: .normal)
            flashOn = false
        }
        
    }
    
    func toggleFlash(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
                
            } catch {
                print("Flash could not be used")
            }
        } else {
            print("Flash unavailable")
        }
    }
    
    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
