//
//  CollectionViewCell.swift
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
}
