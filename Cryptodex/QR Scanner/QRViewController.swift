//
//  QRViewController.swift
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
    var flashOn: Bool!
    
    //define main UI views
    var qrscannerview: QRScannerView!
    var headerview: HeaderView!
    var qrCodeFrameView: UIView?
    var qrscannedsummary: QRScannedSummary!
    
    //add rescan and exit buttons
    let rescanButton = UIButton()
    let exitButton = UIButton()
    
    let flashButton = UIButton()
    let cancelButton = UIButton()
    let scanAnotherButton = UIButton()
    

    //get screen dimensions
    let screen = ScreenDimensions()
    
    
    
    //initialize the viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black
        
        
        // add the scanner app header and the scanner view
        qrscannerview = QRScannerView()
        headerview = HeaderView(dimensions: screen)
        setupHeader()
        flashOn = false
        
        view.addSubview(qrscannerview)
        view.addSubview(headerview)
    
        //start looking for qr codes immediately
        startQRScan()
        
        //configure qr code frame for recognition
        setupQRCodeFrameView()
        
        //setup rescan button
        setupButtons()
        
        
    }
    
    func setupHeader() {
        
        //CUSTOMIZE HEADERVIEW FOR SCANNER
        
        headerview.addContact.isEnabled = false
        headerview.addContact.removeFromSuperview()
        headerview.scanButton.isEnabled = false
        headerview.scanButton.removeFromSuperview()
        
        headerview.appName.text = ""
        headerview.appName.font = UIFont(name: "Avenir-Light", size: 20)
        
    }
    
    func setupButtons() {
        
        //add the rescan button to the view, but dont show or enable it
        rescanButton.setBackgroundImage(UIImage(named: "rescanButton"), for: .normal)
        rescanButton.isEnabled = false
        rescanButton.isHidden = true
        self.view.addSubview(rescanButton)
        
        //add button action for flash
        rescanButton.addTarget(self, action: #selector(rescanQRCode), for: .touchUpInside)
        
        //add constraints
        rescanButton.translatesAutoresizingMaskIntoConstraints = false
        rescanButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        rescanButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        
        //add the exit button to the view
        exitButton.setBackgroundImage(UIImage(named: "exitButton"), for: .normal)
        exitButton.isEnabled = true
        exitButton.isHidden = false
        self.view.addSubview(exitButton)
        
        //add button action for exit
        exitButton.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        
        //add constraints
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: headerview.centerYAnchor, constant: 0).isActive = true
        
        flashButton.setBackgroundImage(UIImage(named: "flashOFF"), for: .normal)
        flashButton.isEnabled = true
        flashButton.isHidden = false
        self.view.addSubview(flashButton)
        
        //add button action for flash
        flashButton.addTarget(self, action: #selector(flashTapped), for: .touchUpInside)
        flashOn = false
        
        //add constraints
        flashButton.translatesAutoresizingMaskIntoConstraints = false
        flashButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        flashButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        
        
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
    
    func startQRScan() {
        
        //create the capture session
        initializeCaptureSession()
        captureSession!.startRunning()
       
        
    }
    
    func initializeCaptureSession() {

        //create instance of capture session
        captureSession = AVCaptureSession()

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
            //insert the preview layer (camera session) below the scannerview labels
            view.layer.insertSublayer(videoPreviewLayer!, below: qrscannerview.layer)
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }
    
    func setupQRCodeFrameView() {
        
        //show green outline of qr code when discovered
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 5
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
        
    }
    
    // add metadataoutput function to translate the qr code and decode information
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            print("No QR code is detected")
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
                
                //check for unique contact identifier
                if String((qrStringValue?.split(separator: ":")[0])!) == "COINDEXUNIQUE_CONTACT" {
                    contactCodeFound(qrStringValue: qrStringValue!)
                } else {
                    walletCodeFound(qrStringValue: qrStringValue!)
                }
               
            }
        }
    }
    
    func removeScannerView() {
        
        //stop the capture session, remove it from view
        captureSession?.stopRunning()
        videoPreviewLayer?.removeFromSuperlayer()
        //remove scanner from view
        qrscannerview.removeFromSuperview()
        
    }
    
    func reauthorizeButtons() {
        
        // remove and add appropriate buttons
        flashButton.isEnabled = false
        flashButton.isHidden = true
        rescanButton.isEnabled = true
        rescanButton.isHidden = false
        view.bringSubviewToFront(rescanButton)
        
    }
    
    
    func contactCodeFound(qrStringValue: String) {
        
        print("\n")
        print("FOUND CONTACT IDENTIFIER")
        print("\n")
        print("QR CODE FULL STRING VALUE")
        print(qrStringValue)
        print("\n")
        
        //create the summary view for the contact
        removeScannerView()
        qrscannedsummary = QRScannedSummary(isContact: true, qrStringValue: qrStringValue)
        view.addSubview(qrscannedsummary)
        reauthorizeButtons()
        
        
    }
    
    
    func walletCodeFound(qrStringValue: String) {
        
        print("\n")
        print("FOUND WALLET IDENTIFIER")
        print("\n")
        print("QR CODE FULL STRING VALUE")
        print(qrStringValue)
        print("\n")
        
        //create the summary view for the wallet
        removeScannerView()
        qrscannedsummary = QRScannedSummary(isContact: false, qrStringValue: qrStringValue)
        view.addSubview(qrscannedsummary)
        reauthorizeButtons()
        
        
    }
    
    @objc func exitTapped() {
        
        //stop the capture session, remove it from view
        captureSession?.stopRunning()
        videoPreviewLayer?.removeFromSuperlayer()
        
        
        //PUSH TO MAIN VIEW CONTROLLER 
        print("Exit Button Registered Touch")
        let mainVC = ViewController()
        getTopViewController()?.present(mainVC, animated: false, completion: nil)
        
        return
    }
    
    @objc func rescanQRCode() {
        
        print("Rescan Button Press Registered")
        rescanButton.removeFromSuperview()
        qrscannedsummary.removeFromSuperview()
        qrscannerview = QRScannerView()
        self.view.addSubview(qrscannerview)
        // look for qr codes
        startQRScan()
        //configure qr code frame for recognition
        setupQRCodeFrameView()
        // add buttons
        setupButtons()
        
    }
    
    func getTopViewController() -> UIViewController? {
        var topViewController = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }
        
        //Add custom animation
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        return topViewController
    }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}

//Add String extension to capitalize first letters only
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
