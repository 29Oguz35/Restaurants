//
//  Models.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import Foundation

struct AllData : Codable {
    let businesses : [businesses]
}
struct businesses : Codable {
    let id : String
    let name : String
    let image_url : URL
    let distance : Double
}
