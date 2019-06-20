//
//  MainView.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/17/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var screen: ScreenDimensions!
    
    lazy var mainHeader: UIView = {
        let mainHeader = UIView()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        return mainHeader
    }()
    
    lazy var contactsView: ContactsView = {
        let contactsView = ContactsView(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        return contactsView
    }()
    
    init(frame: CGRect, dimensions: ScreenDimensions) {
        screen = dimensions
        let viewOrigin = CGPoint(x: 0, y: screen.statusBarHeight)
        let viewSize = CGSize(width: screen.width, height: screen.height*(1-screen.adBannerRatio))
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
        
        addSubview(mainHeader)
        let constraints:[NSLayoutConstraint] = [
            mainHeader.topAnchor.constraint(equalTo: topAnchor),
            mainHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHeader.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        addSubview(contactsView)
        let constraints2:[NSLayoutConstraint] = [
            contactsView.topAnchor.constraint(equalTo: mainHeader.bottomAnchor),
            contactsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contactsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contactsView.heightAnchor.constraint(equalToConstant: 400)
        ]
        NSLayoutConstraint.activate(constraints2)
        
        backgroundColor = .yellow
        
        contactsView.buildTable(dimensions: screen)
        
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
