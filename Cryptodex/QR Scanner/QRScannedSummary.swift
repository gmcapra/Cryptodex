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

    //define contact ui labels
    let contactName = UILabel()
    
    //define wallet ui labels
    let verificationLabel = UILabel()
    let addressTypeLabel = UILabel()
    let addressIdentifierLabel = UILabel()
    
    //define array to store wallet types
    var walletTypes: Array<String>!
    
    
    init(isContact: Bool, qrStringValue: String) {
        
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
        
        //determine wallet or contact to display
        if isContact == true {
            getContactInfo(contactString: qrStringValue)
            
        } else {
            getWalletInfo(walletString: qrStringValue)

        }
        
        
    }
    
    func getContactInfo(contactString: String) {
        
        //initialize array to hold pieces of the contact string
        var piecesArray: Array<String>!
        piecesArray = []
        
        //split the string by the known separator
        let stringPieces = contactString.split(separator: ":")
        
        //add each separate piece to the array
        for index in stringPieces {
            piecesArray.append(String(index))
        }
        
        //get the number of wallets stored in the qr code
        let numberOfWallets = (piecesArray.count - 3)/2
        print("\nThis contact contains " + String(numberOfWallets) + " wallets.\n")
        //get the name from the contact
        let name = piecesArray[1].capitalizingFirstLetter() + " " + piecesArray[2].capitalizingFirstLetter()
        print("This contact's name is " + name + ".\n")
        
        //create array with only the wallet info
        var contactWalletArray: Array<String>!
        contactWalletArray = []
        let walletInfo = numberOfWallets*2 - 1
        for x in 0...walletInfo {
            contactWalletArray.append(piecesArray[3 + x])
        }
        
        //add a few more to test ability to handle any number of wallets (if needed)
//        contactWalletArray.append("bitcoin")
//        contactWalletArray.append("2321432948342")
//        contactWalletArray.append("ethereum")
//        contactWalletArray.append("cjsdkfnrgirowr439834")
        
        setupContactLabels(name: name, contactWalletArray: contactWalletArray)
        
        
    }
    
    
    
    func setupContactLabels(name: String, contactWalletArray: Array<String>) {
        
        //Shows the contact name
        contactName.backgroundColor = .clear
        contactName.text = name
        contactName.textColor = UIColor(displayP3Red: 205/255, green: 196/255, blue: 115/255, alpha: 1.0)
        contactName.textAlignment = NSTextAlignment.center
        contactName.font = UIFont(name: "Avenir-Light", size: 30)
        contactName.contentMode = ContentMode.scaleAspectFit
        
        addSubview(contactName)
        
        //add constraints
        contactName.translatesAutoresizingMaskIntoConstraints = false
        contactName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        contactName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        contactName.heightAnchor.constraint(equalToConstant: 100).isActive = true
        contactName.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        
        var walletTypeToShow: UILabel!
        var walletAddressToShow: UILabel!
        var spacing : CGFloat!
        spacing = 50
        
        //create appropriate labels for each wallet
        for i in stride(from: 0, to: contactWalletArray.count, by: 2) {
            
            walletTypeToShow = UILabel()
            walletTypeToShow.backgroundColor = .clear
            walletTypeToShow.text = contactWalletArray[i].capitalizingFirstLetter()
            walletTypeToShow.textColor = .white
            walletTypeToShow.textAlignment = NSTextAlignment.center
            walletTypeToShow.font = UIFont(name: "Avenir-Light", size: 20)
            walletTypeToShow.contentMode = ContentMode.scaleAspectFit
            addSubview(walletTypeToShow)
            //add constraints
            walletTypeToShow.translatesAutoresizingMaskIntoConstraints = false
            walletTypeToShow.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            walletTypeToShow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            walletTypeToShow.heightAnchor.constraint(equalToConstant: 100).isActive = true
            walletTypeToShow.centerYAnchor.constraint(equalTo: contactName.bottomAnchor, constant: spacing).isActive = true
            
            walletAddressToShow = UILabel()
            walletAddressToShow.backgroundColor = .clear
            walletAddressToShow.text = contactWalletArray[i + 1]
            walletAddressToShow.textColor = .lightGray
            walletAddressToShow.textAlignment = NSTextAlignment.center
            walletAddressToShow.font = UIFont(name: "Avenir-Light", size: 20)
            walletAddressToShow.contentMode = ContentMode.scaleAspectFit
            addSubview(walletAddressToShow)
            //add constraints
            walletAddressToShow.translatesAutoresizingMaskIntoConstraints = false
            walletAddressToShow.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            walletAddressToShow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            walletAddressToShow.heightAnchor.constraint(equalToConstant: 100).isActive = true
            walletAddressToShow.centerYAnchor.constraint(equalTo: walletTypeToShow.centerYAnchor, constant: 25).isActive = true
            
            spacing += 75
        }
        
        
    }
    
    
    func getWalletInfo(walletString: String) {
        
        let addressType = String((walletString.split(separator: ":")[0]))
        let addressIdentifier = String((walletString.split(separator: ":")[1]))
        
        //DEFINE COINBASE WALLET TYPES
        walletTypes = ["bitcoincash","ripple","stellar","ethereum_classic","zcash","bitcoin","litecoin","eos","ethereum"]
        
        //define final address identifier string
        let addressString = String(addressIdentifier)
        var typeString = String(addressType)
        
        //Search for match in known wallet types
        for index in walletTypes {
            if typeString.contains(index) {
                typeString = index.capitalizingFirstLetter()
            }
        }
        
        setupWalletLabels(walletType: typeString, walletAddress: addressString)
        
    }
    
    func setupWalletLabels(walletType: String, walletAddress: String) {
        
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
