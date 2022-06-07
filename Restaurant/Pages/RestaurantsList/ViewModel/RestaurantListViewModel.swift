//
//  RestaurantListViewModel.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import Foundation

struct RestaurantListViewModel {
    let id : String
    let restaurantName : String
    let imageURL : URL
    let distance : String
    
    init(place : businesses) {
        self.id = place.id
        self.restaurantName = place.name
        self.imageURL = place.image_url
        self.distance = "\(String(format: "%.2f", (place.distance/1000)))"
    }
}
