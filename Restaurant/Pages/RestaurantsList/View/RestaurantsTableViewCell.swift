//
//  RestaurantsTableViewCell.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import UIKit
import AlamofireImage

class RestaurantsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgRestaurant: UIImageView!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var imgMark: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func configure(restaurant : RestaurantListViewModel) {
        
        imgRestaurant.af.setImage(withURL : restaurant.imageURL)
        
        lblRestaurantName.text = restaurant.restaurantName
        lblLocation.text = restaurant.distance
        
    }

}
