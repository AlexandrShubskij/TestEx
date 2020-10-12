//
//  CellModel.swift
//  TestEx
//
//  Created by Александр Шубский on 07.10.2020.
//  Copyright © 2020 Александр Шубский. All rights reserved.
//

import Foundation
import UIKit


struct SearchModel {
    var videoImageURL: String
    var videoName: String
    var id: String
    
    init (videoImageURL: String, videoName: String, id:String) {
        self.videoImageURL = videoImageURL
        self.videoName = videoName
        self.id = id
    }
    
    
}


struct DetailsModel {
    var videoID: String
    var videoDescription: String
}
