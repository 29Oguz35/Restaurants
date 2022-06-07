//
//  APICaller.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import Foundation
import Moya

private let API_KEY = "u1c6lK9OFE44wAlpVmeI1hjUbwHiBsIol1B1SoODWMUtWIBMHcYdLJ0QBi9JvI6MfAHweOdtQGGeAvczBwYcBIBPUjIrHwQq0AtVO1nxHUxXxo2tnOHXd1_UtokoYnYx"

enum YelpService {
    
    enum DataProvider : TargetType {
        
        case search(lat : Double, long : Double)
        case details(id : String)
        case reviews(id : String)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        var path: String {
            switch self {
            case .search: return "/search"
            
            case .details(id: let id):
                return "/\(id)"
            case .reviews(id: let id):
                return "/\(id)/reviews"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var task: Task {
            switch self {
            case .search(let lat, let long):
                return .requestParameters(parameters: ["latitude" : lat, "longitude" : long, "limit" : 20, "radius" : 40000], encoding: URLEncoding.queryString)
            case .details(id: _):
                return .requestPlain
                
            case .reviews(id: _):
                return .requestPlain
            }
        }
        
        var headers: [String : String]? {
            return ["Authorization" : "Bearer \(API_KEY)"]
        }
        
        
    }
}
