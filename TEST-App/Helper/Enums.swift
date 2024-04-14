//
//  Enums.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import Foundation

enum HttpMethod:String {
    case Get
}


enum DataError:Error{
    
    case InvalidURL
    case InvalidURLRequest
    case InvalidData
    case DecodingFail
    case EncodingFail
    
    var errorMessage: String {
        switch self {
        case .InvalidURL:
            return "Invalid URL"
        case .InvalidData:
            return "Invalid Data found"
        case .InvalidURLRequest:
            return "Invalid URL request careted"
        case .DecodingFail:
            return "Data parse fail"
        case .EncodingFail:
            return "Not Able to Make Request body param"
        }
    }
}


typealias dataHandleEvent = ((_ dataEvent : ViewModelEvent) -> Void)

enum ViewModelEvent {
    case loading
    case stopLoading
    case feacthed
    case CustomError(message: String)
}

enum CellId:String{
    case MediaImageCellID = "MediaImageCell"
}
