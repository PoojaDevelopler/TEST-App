//
//  ImageFileManager.swift
//  TEST-App
//
//  Created by pnkbksh on 15/04/24.
//

import UIKit

class LocalFileManager{
    
    static let shared = LocalFileManager()
    private init(){}
    
    func savedImage(image:UIImage , imageName:String , folderName:String){
        //craete folder for saving image if already there if will igbore
        createFolder(folderName: folderName)
        
        //get path for image
        guard let data = image.jpegData(compressionQuality: 0.5) ,
                let url = getUrlForImage(imageName: imageName, folderName: folderName) else{return}
        
        //save image
        do{
            try data.write(to: url)
        }
        catch let error{
            print("error saving imagge \(imageName) .. \(error)")
        }
        
    }
 
    private func createFolder(folderName:String){
        guard let url = getUrlForFolder(folderName: folderName) else { return  }
        if !FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error{
                print("error making directorty  folder: \(folderName)... \(error)")
                
            }
        }
    }
    
   private func getUrlForFolder(folderName:String) -> URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    
    private func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getUrlForFolder(folderName: folderName) else { return nil }
        guard let fileName = URL(string: imageName) else { return nil }
        
        //break the path to get url
        let pathToStore = fileName.pathComponents[2] + fileName.pathComponents[3] + fileName.lastPathComponent
        return folderUrl.appendingPathComponent(pathToStore)
    }
 
    
    func getImage(imageName:String , folderName:String) -> UIImage?{
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName) , FileManager.default.fileExists(atPath: url.path)
        else { return  nil}
        
        return UIImage(contentsOfFile: url.path)
    }
}

