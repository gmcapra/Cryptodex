//
//  headerView.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/10/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    var scanButton = UIButton()
    var addContact = UIButton()

    let appName = UILabel()

    var screen: ScreenDimensions!

    init(dimensions: ScreenDimensions) {
        screen = dimensions
        let viewOrigin = CGPoint(x: 0, y: screen.statusBarHeight)
        let viewSize = CGSize(width: screen.width, height: screen.headerHeight)
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))

        backgroundColor = .black
        buildView()
        
    }
    
    func buildView() {
        
        for btn in [scanButton, addContact] {
            addSubview(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.backgroundColor = .lightGray
            setConstraint(to: btn, from: self, on: .height, and: .height, mult: 0.8, constant: 0)
            setConstraint(to: btn, from: self, on: .width, and: .height, mult: 0.8, constant: 0)
            setConstraint(to: btn, from: self, on: .top, and: .top, mult: 1, constant: screen.headerHeight*0.1)
        }
        
        setConstraint(to: scanButton, from: self, on: .leading, and: .leading, mult: 1, constant: screen.statusBarHeight/2)
        setConstraint(to: addContact, from: self, on: .trailing, and: .trailing, mult: 1, constant: -screen.statusBarHeight/2)
        
        addSubview(appName)
        appName.translatesAutoresizingMaskIntoConstraints = false
        appName.text = "Cryptodex"
        appName.textColor = UIColor(displayP3Red: 205/255, green: 196/255, blue: 115/255, alpha: 1.0)
        appName.textAlignment = .center
        appName.font = UIFont.systemFont(ofSize: 25.0)
        //label.font = UIFont(name:"fontname", size: 20.0)
        setConstraint(to: appName, from: self, on: .height, and: .height, mult: 0.8, constant: 0)
        setConstraint(to: appName, from: self, on: .width, and: .width, mult: 1, constant: -132)
        setConstraint(to: appName, from: self, on: .centerX, and: .centerX, mult: 1, constant: 0)
        setConstraint(to: appName, from: self, on: .top, and: .top, mult: 1, constant: screen.headerHeight*0.1)
        
        //////////////////////////////////////////////////////////////////////
        //GIANLUCA EDITS HERE:
        //Customizing right header button to access manual contact entry.
        addContact.backgroundColor = .clear
        addContact.setBackgroundImage(UIImage(named: "addContact"), for: .normal)
        addContact.addTarget(self, action: #selector(showContactEntry), for: .touchUpInside)
        
        //Customizing left header button to access qr scanner immediately
        scanButton.backgroundColor = .clear
        scanButton.setBackgroundImage(UIImage(named: "scanButton"), for: .normal)
        scanButton.addTarget(self, action: #selector(showQRScanner), for: .touchUpInside)

    }
    
    ////////////////////////////////////////////////
    //GIANLUCA ADD FUNCTION:
    //Adding function for action to take when scan button is pressed.
    @objc func showQRScanner() {
        
        let qrVC = QRViewController()
        let topVC = getTopViewController()
        
        topVC!.present(qrVC, animated: true, completion: nil)

        
    }
    
    ////////////////////////////////////////////////
    //GIANLUCA ADD FUNCTION:
    //Adding function for action to take when add contact button is pressed.
    @objc func showContactEntry() {
        
        /*
            Code that presents the views in the manual contact entry flow.
            Since you will likely want to remain with the main VC for this,
            I will defer to you on the architecture you want to use.
        */
        
        
    }
    
    ///////////////////////////////////////////////
    //GIANLUCA ADD FUNCTION:
    //This function returns the top view controller so that navigation can
    //occur between vcs.
    func getTopViewController() -> UIViewController? {
        var topViewController = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }
        
        //Add custom animation
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.window!.layer.add(transition, forKey: kCATransition)
        
        return topViewController
    }
    
    
    @objc func setConstraint(to: AnyObject, from: AnyObject, on: NSLayoutConstraint.Attribute, and: NSLayoutConstraint.Attribute, mult: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: to, attribute: on, relatedBy: .equal, toItem: from, attribute: and, multiplier: mult, constant: constant)
        addConstraints([constraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
