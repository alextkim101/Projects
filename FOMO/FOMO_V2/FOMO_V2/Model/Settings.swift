//
//  Settings.swift
//  FOMO_V2
//
//  Created by Alex  on 2/3/19.
//  Copyright © 2019 Samuel Kyu-Seo Lee. All rights reserved.
//

import Foundation

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
