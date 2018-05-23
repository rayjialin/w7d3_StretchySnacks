//
//  ImageCollectionViewCell.swift
//  StretchySnacks
//
//  Created by ruijia lin on 5/23/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
//        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    
     func setupView(){
        self.addSubview(foodImageView)
        
//        foodImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        foodImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        foodImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
    }
}
