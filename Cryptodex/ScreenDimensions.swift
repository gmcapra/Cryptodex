//
//  screenSize.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/11/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

struct ScreenDimensions {
    
    let bounds: CGRect
    let height: CGFloat
    let width: CGFloat
    
    let statusBar: CGSize
    let statusBarHeight: CGFloat
    
    let headerHeight: CGFloat
    let tableViewHeight: CGFloat
    let adBannerHeight: CGFloat
    
    let headerRatio: CGFloat = 0.07
    let tableViewRatio: CGFloat = 0.84
    let adBannerRatio: CGFloat = 0.09
    
    init() {
        self.statusBar = UIApplication.shared.statusBarFrame.size
        self.statusBarHeight = statusBar.height
        
        self.bounds = UIScreen.main.bounds
        self.height = bounds.height - statusBarHeight
        self.width = bounds.width
        
        self.headerHeight = headerRatio * height
        self.tableViewHeight = tableViewRatio * height
        self.adBannerHeight = adBannerRatio * height
        
        print("screenHeight: \(height), screenWidth: \(width), statusBarHeight: \(statusBarHeight)")
    }

}
