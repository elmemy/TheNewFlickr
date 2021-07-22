//
//  URLS.swift
//  MyFarm
//
//  Created by Ahmed Elmemy on 24/06/2021.
//

import Foundation

struct URLs {
    
    //Base URL

    static let port = "4548"
    
    static let key = "2f4474593087477a29b8b4a4683d765b"
    static let secret = "0e57ea456c811f11"
    
    static let BASE = "https://www.flickr.com/"

    static let url = BASE + "services/rest/?method=flickr.photos.search&api_key=\(key)&text=cat&format=json&nojsoncallback=1"

    
}
