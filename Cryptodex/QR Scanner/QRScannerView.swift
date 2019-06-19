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
    
    let verificationLabel = UILabel()
    let addressTypeLabel = UILabel()
    let addressIdentifierLabel = UILabel()
    
    let flashButton = UIButton()
    let cancelButton = UIButton()
    let scanAnotherButton = UIButton()
    
    let testContactQR = ContactQRView(contactString: "COINDEXUNIQUE_CONTACT:gianluca:capraro:wallet1:fndfirunueriner232:wallet2:fndskjfsdf3223n5kj")
    
    //keep track of flash for image updates
    var flashOn: Bool!
    
    
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
        setupButtons()
        
        
        /*
        ////////////CODE FOR TESTING THE CONTACTQRVIEW//////////////
        //The generated qr code will show up in the qr scanning viewcontroller when this code is run.
        //add the scanning frame image for reference
        addSubview(testContactQR)
        self.bringSubviewToFront(testContactQR)
        //add constraints
        testContactQR.contentMode = ContentMode.scaleAspectFit
        testContactQR.translatesAutoresizingMaskIntoConstraints = false
        testContactQR.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        testContactQR.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        testContactQR.heightAnchor.constraint(equalToConstant: 500).isActive = true
        testContactQR.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        ///////////////////////////////////////////////////////////////
        */
        
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
        
        
        //Create placeholders for the summary information
        
        
        //Shows the type of cryptocurrency wallet that was scanned
        addressTypeLabel.backgroundColor = .clear
        addressTypeLabel.text = ""
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
        verificationLabel.text = ""
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
        addressIdentifierLabel.text = ""
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
    
    
    @objc func flashTapped() {
        
        if flashOn == false {
            toggleFlash()
            flashButton.setBackgroundImage(UIImage(named: "flashON"), for: .normal)
            
        } else {
            toggleFlash()
            flashButton.setBackgroundImage(UIImage(named: "flashOFF"), for: .normal)
        }
        
    }
    
    func toggleFlash() {
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let device = deviceDiscoverySession.devices.first
            else {return}
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                let on = device.isTorchActive
                if on != true && device.isTorchModeSupported(.on) {
                    try device.setTorchModeOn(level: 1.0)
                    flashOn = true
                } else if device.isTorchModeSupported(.off){
                    device.torchMode = .off
                    flashOn = false
                } else {
                    print("Flash mode is not supported")
                }
                device.unlockForConfiguration()
            } catch {
                print("Flash could not be used")
            }
        } else {
            print("Flash is not available")
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
