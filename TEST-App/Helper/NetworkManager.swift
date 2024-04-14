//
//  NetworkManager.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import Foundation

//MARK: Network Calls
class NetworkManager{
   
    let apiHandler : APIHandler
    let responseHandler : ResponseHandler
    
    init(aPIHandler:APIHandler = APIHandle() , responseHandler:ResponseHandler = ResponseHandle()) {
        
        self.apiHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func featchData<T:Codable>(type:T.Type , url:URL , headerParam:[String:String]? ,completion: @escaping(Result<T , DataError>) -> Void ){
        
        apiHandler.apiHandler(type: type , url: url, params: nil, header: headerParam, method: .Get) { result  in
            
            switch result{
                
            case .success(let data):
                
                self.responseHandler.featchModel(type: type, data: data) { decodedresult in
                    switch decodedresult {
                        
                    case .success(let model):
                        completion(.success(model))
                        
                        
                    case .failure(let error):
                        completion(.failure(error))
                        
                    }
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
   
}


//MARK: Api Handler
protocol APIHandler {
    
  func apiHandler<T:Codable>(type:T.Type? , url:URL , params: Codable? , header:[String:String]?  , method: HttpMethod , completion: @escaping(Result<Data , DataError>) -> Void )
}


class APIHandle : APIHandler{
    
    func apiHandler<T>(type: T.Type?, url: URL, params: Codable? = nil , header: [String : String]?, method: HttpMethod, completion: @escaping (Result<Data, DataError>) -> Void) where T : Decodable, T : Encodable {
     
        var jsonData: Data?
        
        if let params = params {
            do {
                jsonData = try JSONEncoder().encode(params)
            } catch {
                completion(.failure(.EncodingFail))
                return
            }
        }
        
        var request : URLRequest?
        request = URLRequest(url: url)
        
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request?.setValue("application/json", forHTTPHeaderField: "Accept")
        request?.httpBody = jsonData
        
        request?.allHTTPHeaderFields = header
        request?.httpMethod = method.rawValue
        
        guard let urlRequest = request else {
            completion(.failure(.InvalidURLRequest))
            return
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 50
        configuration.timeoutIntervalForResource = 50
        
        let task = URLSession(configuration: configuration)
        
        task.dataTask(with: urlRequest as URLRequest) { (data, response, error) -> Void in
            
            guard let data = data , error == nil else {
                return completion(.failure(.InvalidData))
            }
            completion(.success(data))
        }.resume()
        
    }
    
}


//MARK: Api Response Handler
protocol ResponseHandler {
    func featchModel<T:Codable>(type:T.Type , data:Data , completion: @escaping(Result<T , DataError>) -> Void )
}

class ResponseHandle : ResponseHandler {
 
    func featchModel<T: Codable>(type: T.Type, data: Data, completion: @escaping(Result<T, DataError>) -> Void) {
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedResponse))
        } catch {
            print("Error decoding JSON: \(error)")
            completion(.failure(.DecodingFail))
        }
    }
    
}
