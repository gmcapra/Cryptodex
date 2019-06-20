//
//  Header2.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/18/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class MainScreen: UIView {

    var screen: ScreenDimensions!
    
    var mainHeader: HeaderView!
    var mainTable: ContactsView!
    
    init(dimensions: ScreenDimensions) {
        screen = dimensions
        let viewOrigin = CGPoint(x: 0, y: screen.statusBarHeight)
        let viewSize = CGSize(width: screen.width, height: screen.height*(1-screen.adBannerRatio))
        super.init(frame: CGRect(origin: viewOrigin, size: viewSize))
        
        mainHeader = HeaderView(dimensions: screen)
        mainTable = ContactsView(frame: CGRect.zero, style: .plain)
        addSubview(mainHeader)
        addSubview(mainTable)
        
        backgroundColor = .yellow
        buildView()
        
    }
    
    func buildView() {
        
        let constraints = [
            mainHeader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainHeader.topAnchor.constraint(equalTo: self.topAnchor),
            mainHeader.widthAnchor.constraint(equalToConstant: screen.width),
            mainHeader.heightAnchor.constraint(equalToConstant: screen.headerHeight)
        ]
        NSLayoutConstraint.activate(constraints)
        mainHeader.buildView()

        let constraints2 = [
            mainTable.topAnchor.constraint(equalTo: mainHeader.bottomAnchor),
            mainTable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainHeader.widthAnchor.constraint(equalToConstant: screen.width),
            mainTable.heightAnchor.constraint(equalToConstant: screen.height-screen.headerHeight)
        ]
        NSLayoutConstraint.activate(constraints2)
//        mainTable.buildTable(dimensions: screen)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
