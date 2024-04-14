//
//  HomeViewModel.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import Foundation


enum ViewModelEvent {
    case loading
    case stopLoading
    case CustomError(message: String)
}



class HomeViewModel {
    
    var mediaModel = [CoveragesMediaModel]()
    var vmUpdate: ViewModelEvent? = .CustomError(message: "")
    typealias dataHandleEvent = ((_ dataEvent : ViewModelEvent) -> Void)

    
    private var apiService: ApiServices
    
    init(apiService: ApiServices = ApiServices()) {
        self.apiService = apiService
    }
    
    func fetchMediaList() {
        self.vmUpdate = .loading
        
        apiService.fetchMediaData { [weak self] result in
            guard let self = self else { return }
            self.vmUpdate = .stopLoading
            
            switch result {
                
            case .success(let mediaModel):
                self.mediaModel = mediaModel
                print(mediaModel)
                
            case .failure(let error):
                print("Failed data:", error)
                self.vmUpdate = .CustomError(message: "Something went wrong")
            }
        }
    }
    
}
