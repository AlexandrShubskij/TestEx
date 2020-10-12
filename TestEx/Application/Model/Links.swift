//
//  Links.swift
//  TestEx
//
//  Created by Александр Шубский on 07.10.2020.
//  Copyright © 2020 Александр Шубский. All rights reserved.
//

import Foundation
import UIKit


class ReturnLink {
    
    static func returnSearchLink(text: String) -> String {
        return  "https://www.googleapis.com/youtube/v3/search?q=\(text)&type=video&key=AIzaSyCwgBCwzBlxDVj55OoUmvkIpplClT2taK8&part=snippet&maxResults=15"
    }
    static func returnDetailsLink(id: String) -> String {
        return  "https://www.googleapis.com/youtube/v3/videos?id=\(id)&key=AIzaSyCwgBCwzBlxDVj55OoUmvkIpplClT2taK8&part=snippet"
    }
    
    
}






// https://www.googleapis.com/youtube/v3/videos?id=VFS3pErYesU&key=AIzaSyCwgBCwzBlxDVj55OoUmvkIpplClT2taK8&part=snippet - инфа о конкретном видосе
// https://www.googleapis.com/youtube/v3/search?q=shadowlands&key=AIzaSyCwgBCwzBlxDVj55OoUmvkIpplClT2taK8&part=snippet&maxResults=15 - поиск видосов (отсортирован по релевантности)
/*
 
 let mainUrl = "https://www.googleapis.com/youtube/v3/"
 let apiKeyAndModifInfo = "&key=AIzaSyCwgBCwzBlxDVj55OoUmvkIpplClT2taK8&part=snippet"
 let maxResults = "&maxResults=15"
 let searchPart = "search?q="
 let infoPart = "videos?id="
 
 
 
 */

