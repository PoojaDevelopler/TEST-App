//
//  HomeViewModel.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import Foundation


class HomeViewModel {
    
    var mediaModel = [CoveragesMediaModel]()
    var updates: dataHandleEvent?
    
    private var apiService: ApiServices
    
    init(apiService: ApiServices = ApiServices()) {
        self.apiService = apiService
    }
    
    func fetchMediaList() {
        self.updates?(.loading)
        
        apiService.fetchMediaData { [weak self] result in
            guard let self = self else { return }
            self.updates?(.stopLoading)
            
            switch result {
            case .success(let mediaModel):
                self.mediaModel = mediaModel
                print(mediaModel)
                self.updates?(.feacthed)
            case .failure(let error):
                print("Failed data:", error)
                self.updates?(.CustomError(message: error.localizedDescription))
            }
        }
    }
    
    func getImageString(forIndex index: Int) -> String? {
        guard index < mediaModel.count else { return nil }
        
        let item = mediaModel[index]
        guard let thumbnail = item.thumbnail,
              let domain = thumbnail.domain,
              let basePath = thumbnail.basePath,
              let lastQuality = thumbnail.qualities?.last,
              let key = thumbnail.key
        else {
            return nil
        }
        return "\(domain)/\(basePath)/\(lastQuality)/\(key)"
    }
    
}
