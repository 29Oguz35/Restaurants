//
//  MealDetailsCollectionViewCell.swift
//  Restaurant
//
//  Created by naruto kurama on 31.05.2022.
//

import UIKit

class MealDetailsCollectionViewCell: UICollectionViewCell {
    
    let imgRestaurant = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        settings()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func settings() {
        
        contentView.addSubview(imgRestaurant)
        imgRestaurant.translatesAutoresizingMaskIntoConstraints = false
        imgRestaurant.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            imgRestaurant.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imgRestaurant.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgRestaurant.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgRestaurant.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
        
    }
    
}
