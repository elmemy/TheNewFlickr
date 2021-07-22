//
//  APIService.swift
//  TheNewFlickr
//
//  Created by Ahmed Elmemy on 18/07/2021.
//

import Foundation
import Alamofire
enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchPopularPhoto( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
 
    
    // Simulate a long waiting for fetching
    
    
    var Home : Photos?
    var MoviesData   = [Photo]()
    
    
    
    func fetchPopularPhoto( complete: @escaping ( _ success: Bool, _ data: [Photo], _ error: APIError?)->()) {
        DispatchQueue.global().async {
            sleep(3)
            Alamofire.request(URLs.url, method: .get, parameters: nil).responseJSON { (response) in
                
                switch response.result{
                case .success(_):
                    
                    do{
                        let data = try JSONDecoder().decode(PhotosModel.self, from: response.data!)
                        self.Home = data.photos
                        self.handeleViewData(homeData: data)
                        complete(true, self.MoviesData, nil)
                        
                    }catch{
                        complete(false,[],APIError.serverOverload)
                        print(error)
                    }
                    
                case .failure(_):
                    complete(false,[],APIError.noNetwork)
                }
            }
            
        }
    }
    
    
    
    
    

    func handeleViewData(homeData: PhotosModel){
        MoviesData = homeData.photos.photo
    }
}

