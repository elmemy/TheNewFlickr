//
//  ViewController.swift
//  TheNewFlickr
//
//  Created by Abdoelrhman Eaita on 13/07/2021.
//

import UIKit

struct APIInfo {
    static let key = "2f4474593087477a29b8b4a4683d765b"
    static let secret = "0e57ea456c811f11"
    static let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&text=cat&format=json&nojsoncallback=1"
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

