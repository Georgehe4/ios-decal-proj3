//
//  CollectionViewImageCell.swift
//  Photos
//
//  Created by George He on 4/10/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//
import UIKit

class CollectionViewImageCell: UICollectionViewCell {
    
    var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImageView(frame: self.contentView.bounds)
        contentView.addSubview(image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        image.frame = self.contentView.bounds
        
        image.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
