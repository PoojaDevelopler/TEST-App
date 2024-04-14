//
//  MediaImageCell.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import UIKit

class MediaImageCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var mediaImage:UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.prepareForReuse()
    }
    
    var mediaImageString:String?{
        didSet{
            updatedMediaImage()
        }
    }
    
    
    private func updatedMediaImage(){
        
        if let mediaImageString {
            self.mediaImage.covertUrlToImage(urlString: mediaImageString)
        }
    }
    
}
