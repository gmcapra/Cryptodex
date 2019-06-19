//
//  ContactQRView.swift
//  Cryptodex
//
//  Created by Gianluca Capraro on 6/19/19.
//  Copyright © 2019 toggle. All rights reserved.
//

// This is a custom UIImage view that generates and displays a QR Code from a given string.
// READ BELOW FOR PROPER FORMATTING:
/*
 
 The QR Code Generated must be properly formatted for sharing between users.
 
Formatting guidelines are as follows:
    - contacts must be uniquely identified with "COINDEXUNIQUE_CONTACT" as the beginning of the string
    - all fields are separated by the ":" character
    - follows convention (contactidentifier:firstname:lastname:wallet1Type:wallet1Address:wallet2Type:wallet2Address:...)

 - Example contact we want to share
        - Name is Tony Stark,
          Bitcoin Wallet with address 1dC45dsfi3010EEgnffX
          Ethereum Wallet with address 0cxfRE5434FDJk
 
 - Example string to pass would be:
    "COINDEXUNIQUE_CONTACT:Tony:Stark:Bitcoin:1dC45dsfi3010EEgnffX:Ethereum:0cxfRE5434FDJk"

 */


import Foundation
import UIKit

class ContactQRView: UIImageView {
    
    //get screen dimensions
    let screen = ScreenDimensions()

    
    init(contactString: String) {
        
        //Initialize the size of the view
        let viewHeight = 3*screen.width/4
        let viewWidth = 3*screen.width/4
        let originX = screen.width/2 - viewWidth/2
        let originY = screen.height/2 - 8*viewHeight/9
        let viewOrigin = CGPoint(x: originX, y: originY)
        let viewSize = CGSize(width: viewWidth, height: viewHeight)
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
        
        //generate qr code from string
        generateQRCode(contactString: contactString)
        
    }
    
    func generateQRCode(contactString: String) {
        
        // encode string to data
        let contactData = contactString.data(using: String.Encoding.ascii)
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        qrFilter.setValue(contactData, forKey: "inputMessage")
        guard let qrImage = qrFilter.outputImage else { return }
        
        // scale the image up
        let scaleTransformation = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQRImage = qrImage.transformed(by: scaleTransformation)
        
        // process the image for display and get a usable UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQRImage, from: scaledQRImage.extent) else { return }
        let processedImage = UIImage(cgImage: cgImage)
        
        self.image = processedImage
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
