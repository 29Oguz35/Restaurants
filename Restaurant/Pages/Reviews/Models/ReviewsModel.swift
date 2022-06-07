//
//  ReviewsModel.swift
//  Restaurant
//
//  Created by naruto kurama on 31.05.2022.
//

import Foundation

struct User: Decodable {
    let image_url : URL
    let name : String
}
struct Review : Decodable {
    let rating : Double
    let text : String
    let user : User
}
struct ReviewResponse : Decodable {
    let reviews : [Review]
}
