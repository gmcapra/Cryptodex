//
//  ViewController.swift
//  CryptodexQRScanner
//
//  Created by Gianluca Capraro on 6/13/19.
//  Copyright © 2019 gmc. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    //define qr capture session variables
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    //define main UI views
    var qrheader: QRHeaderView!
    var qrscannerview: QRScannerView!
    var qrCodeFrameView: UIView?

    
    //get screen dimensions
    let screen = ScreenDimensions()
    
    //define ui labels and buttons
    let scanButton = UIButton()
    let addressTypeLabel = UILabel()
    let addressIdentifierLabel = UILabel()
    
    
    //initialize booleans for capture status
    var isScanning: DarwinBoolean!
    
    //initialize the viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // add the scanner app header and the scanner view
        qrheader = QRHeaderView()
        qrscannerview = QRScannerView()
        view.addSubview(qrheader)
        view.addSubview(qrscannerview)
    
        // configure scan button and label to begin and verify scanning
        setupScanButton()
        setupScanLabels()
        
        //configure qr code frame
        setupQRCodeFrameView()
        
        //set isScanning variable to false
        isScanning = false
        
    }
    
    func initializeCaptureSession() {
        
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession = AVCaptureSession()
            captureSession!.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession!.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // Initialize the video preview layer and add it as a sublayer to the qrscanner view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = qrscannerview.frame
            view.layer.addSublayer(videoPreviewLayer!)
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }
    
    func setupQRCodeFrameView() {
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 5
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
        
    }
    
    func setupScanButton() {
        
        // Define the button layout
        scanButton.backgroundColor = .white
        scanButton.setTitleColor(.black, for: .normal)
        scanButton.setTitle("Scan", for: .normal)
        
        // add button to view
        view.addSubview(scanButton)
        
        // define the function of the button
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        
        //add constraints
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        scanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        scanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        scanButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scanButton.centerYAnchor.constraint(equalTo: qrscannerview.bottomAnchor, constant: 50).isActive = true

    }
    
    @objc func scanButtonTapped() {
        
        //begin the capture session if not yet started
        if isScanning == false {
            //create the capture session
            initializeCaptureSession()
            captureSession!.startRunning()
            scanButton.setTitle("Stop", for: .normal)
            scanButton.setTitleColor(.red, for: .normal)
            isScanning = true

        } else { //remove video preview layer and reset button
            captureSession?.stopRunning()
            scanButton.setTitle("Scan", for: .normal)
            scanButton.setTitleColor(.black, for: .normal)
            isScanning = false
            videoPreviewLayer?.removeFromSuperlayer()
            
            
        }
        
    }
    
    func setupScanLabels() {
        
        // Define the label layout
        addressTypeLabel.backgroundColor = .clear
        addressTypeLabel.text = "Wallet Type"
        addressTypeLabel.textColor = .white
        addressTypeLabel.textAlignment = NSTextAlignment.center
        
        // add button to view
        view.addSubview(addressTypeLabel)
        
        //add constraints
        addressTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        addressTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        addressTypeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addressTypeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addressTypeLabel.centerYAnchor.constraint(equalTo: scanButton.bottomAnchor, constant: 50).isActive = true
        
        // Define the label layout
        addressIdentifierLabel.backgroundColor = .clear
        addressIdentifierLabel.text = "Wallet Address"
        addressIdentifierLabel.textColor = .white
        addressIdentifierLabel.textAlignment = NSTextAlignment.center
        
        // add button to view
        view.addSubview(addressIdentifierLabel)
        
        //add constraints
        addressIdentifierLabel.translatesAutoresizingMaskIntoConstraints = false
        addressIdentifierLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        addressIdentifierLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addressIdentifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addressIdentifierLabel.centerYAnchor.constraint(equalTo: addressTypeLabel.bottomAnchor, constant: 10).isActive = true
        
    }
    
    // add metadataoutput function to translate the qr code and decode information
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            addressTypeLabel.text = "No QR code is detected"
            addressIdentifierLabel.text = ""
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                
                let qrStringValue = metadataObj.stringValue
                let addressType = qrStringValue?.split(separator: ":")[0]
                let addressIdentifier = qrStringValue?.split(separator: ":")[1]

                addressTypeLabel.text = String(addressType!).uppercased() + "Wallet"
                addressIdentifierLabel.text = String(addressIdentifier!)
                
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}

