//
//  DetailsModel.swift
//  Restaurant
//
//  Created by naruto kurama on 31.05.2022.
//

import Foundation
import CoreLocation

struct Details : Decodable {
    
    let price : String
    let phone : String
    let rating : Double
    let name : String
    let is_closed : Bool
    let photos : [URL]
    let coordinates : CLLocationCoordinate2D
    let id : String
}
extension CLLocationCoordinate2D : Decodable {
    enum Keys : CodingKey {
        case latitude
        case longitude
    }
    public init(from decoder: Decoder) throws {
        let cont = try decoder.container(keyedBy: Keys.self)
        let lat = try cont.decode(Double.self, forKey: .latitude)
        let long = try cont.decode(Double.self, forKey: .longitude)
        self.init(latitude: lat, longitude: long)
    }
}
