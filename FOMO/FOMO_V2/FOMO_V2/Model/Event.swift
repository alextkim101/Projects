//
//  Event.swift
//  FOMO_V2
//
//  Created by Samuel Kyu-Seo Lee on 12/25/18.
//  Copyright © 2018 Samuel Kyu-Seo Lee. All rights reserved.
//

import UIKit

class Event: NSObject {
    
    var _id:String?
    var id: String?
    var title: String?
    var time: String?
    var date: String?
    var address: String?
    var location: String?
    var descript: String?
    var thumbNailImageName: String?
    var lat: String?
    var lng: String?

    
    var channel: Channel? 
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
