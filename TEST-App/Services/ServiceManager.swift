//
//  ServiceManager.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import Foundation


class ApiServices{
    
    func fetchMediaData(completion:@escaping (Result<[CoveragesMediaModel] , DataError>) -> Void){
        guard let url = URL(string: Endpoint.imageAPI) else {
            return completion(.failure(.InvalidURL))
        }
        NetworkManager().featchData(type: [CoveragesMediaModel].self, url: url, headerParam: [:], completion: completion)
    }
}
