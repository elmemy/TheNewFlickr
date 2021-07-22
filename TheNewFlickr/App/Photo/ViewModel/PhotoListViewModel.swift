//
//  PhotoListViewModel.swift
//  TheNewFlickr
//
//  Created by Ahmed Elmemy on 18/07/2021.
//

import Foundation

class PhotoListViewModel {
    
    let apiService: APIServiceProtocol
    
    private var photos: [Photo] = [Photo]()
    
    private var cellViewModels: [PhotoListCellViewModel] = [PhotoListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    // callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    
    var selectedPhoto: Photo?
    var isAllowSegue: Bool = false
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        state = .loading
        apiService.fetchPopularPhoto { [weak self] (success, photos, error) in
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                self.state = .error
                self.alertMessage = error?.rawValue
                return
            }
            
            self.processFetchedPhoto(photos: photos)
            self.state = .populated
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PhotoListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( photo: Photo ) -> PhotoListCellViewModel {
        
        //Wrap a description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        let photoUrl = "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_b.jpg"
        
        
        return PhotoListCellViewModel( titleText: photo.title,
                                       descText: photo.title,
                                       imageUrl: photoUrl
        )
    }
    
    private func processFetchedPhoto( photos: [Photo] ) {
        self.photos = photos // Cache
        var vms = [PhotoListCellViewModel]()
        for photo in photos {
            vms.append( createCellViewModel(photo: photo) )
        }
        self.cellViewModels = vms
    }
    
}

extension PhotoListViewModel {
    func userPressed( at indexPath: IndexPath ){
        let photo = self.photos[indexPath.row]
        self.isAllowSegue = true
        
        self.selectedPhoto = photo
        
        
    }
}
