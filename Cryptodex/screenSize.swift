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
    let height: Double
    let width: Double
    
    let statusBar: CGSize
    let statusBarHeight: Double
    
    let headerHeight: Double
    let tableViewHeight: Double
    let adBannerHeight: Double
    
    let headerRatio: Double = 0.056
    let tableViewRatio: Double = 0.854
    let adBannerRatio: Double = 0.09
    
    init() {
        self.statusBar = UIApplication.shared.statusBarFrame.size
        self.statusBarHeight = Double(statusBar.height)
        
        self.bounds = UIScreen.main.bounds
        self.height = Double(bounds.height) - statusBarHeight
        self.width = Double(bounds.width)
        
        self.headerHeight = headerRatio * height
        self.tableViewHeight = tableViewRatio * height
        self.adBannerHeight = adBannerRatio * height
        
        print("screenHeight: \(height), screenWidth: \(width), statusBarHeight: \(statusBarHeight)")
    }

}
