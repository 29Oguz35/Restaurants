//
//  DetailsViewModel.swift
//  Restaurant
//
//  Created by naruto kurama on 31.05.2022.
//

import Foundation
import CoreLocation

struct DetailsViewModel {
    
    let restaurantName : String
    let phoneNumber : String
    let price : String
    let closed : String
    let score : String
    let imageRestaurants : [URL]
    let coordinate : CLLocationCoordinate2D
    let id : String
    
    init(detail : Details) {
        self.restaurantName = detail.name
        self.phoneNumber = detail.phone
        self.price = detail.price
        self.score = "\(detail.rating) / 5"
        self.coordinate = detail.coordinates
        self.imageRestaurants = detail.photos
        self.id = detail.id
        self.closed = detail.is_closed ? "Close" : "Open"
      
    }
}
