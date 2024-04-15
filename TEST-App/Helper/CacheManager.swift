//
//  CacheManager.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()
private let localCache = LocalFileManager.shared
private let imageLoader = ImageLoader()

fileprivate  func showAlert(message: String) {
     DispatchQueue.main.async {
         let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default))
         if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController {
             rootViewController.present(alert, animated: true, completion: nil)
         }
     }
 }

extension UIImageView {
    func setImage(url: String, placeholder: String? = nil) {
        self.image = UIImage(named: placeholder ?? "placeholder")
        self.covertUrlToImage(urlString: url)
    }
}

extension UIImageView{
    
    private func covertUrlToImage(urlString: String){
        guard let url = URL(string: urlString) else { return }
        
        //Check if image is available in cache
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) as? UIImage {
            self.image = cachedImage
            return
        }
        
        
        // Image not found in memory cache, check disk cache
        if let cachedImage = localCache.getImage(imageName: urlString, folderName: "MediaImage"){
            self.image = cachedImage
            imageCache.setObject(cachedImage, forKey: urlString as NSString)
            return
        }
        
        // if image is not availabe will donwload
        Task {
            if let image = await imageLoader.loadImage(from: url) {
                self.image = image
            } else {
                showAlert(message: "image not found")
            }
        }
    }
}


actor ImageLoader {
    
    func loadImage(from url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            
            // Cache the image
            imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
            
            //save image to disk
            localCache.savedImage(image: image, imageName: url.absoluteString, folderName: "MediaImage")
            
            return image
            
        } catch {
            print("Error loading image from \(url.absoluteString): \(error)")
            showAlert(message: error.localizedDescription)
            return UIImage(named: "placeholder")
        }
    }
}


