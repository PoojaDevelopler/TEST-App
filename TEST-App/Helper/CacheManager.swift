//
//  CacheManager.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()


extension UIImageView {
    
    func covertUrlToImage(urlString: String, placeholder: UIImage?=nil){
        
        guard let url = URL(string: urlString) else { return }
        
        // Set placeholder image
        self.image = UIImage(named: "placeholder")
        
        // Check if image is available in cache
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) as? UIImage {
            self.image = cachedImage
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else { return }
                
                // Cache the image
                imageCache.setObject(image, forKey: NSString(string: urlString))
                
                // Update UI on the main thread
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.image = image
                }
            } catch {
                print("Error loading image from \(urlString): \(error)")
            }
        }
    }
       
}
