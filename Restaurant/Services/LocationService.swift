//
//  LocationService.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import Foundation
import CoreLocation

enum Results<K> {
    case success(K)
    case wrong(Error)
}

final class LocationService: NSObject {
    
    private let manager : CLLocationManager
    
    init(manager : CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        self.manager.startUpdatingLocation()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.delegate = self
        self.manager.distanceFilter = CLLocationDistance(exactly: 250)!
        
    }
    var currentCoordinate : CLLocationCoordinate2D?
    var newLocation : ((Results<CLLocation>)-> Void)?
    var changeLocation : ((Bool)-> Void)?
    
   
    
    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    func askPermission() {
        manager.requestWhenInUseAuthorization()
    }
    func getLocation() {
        manager.requestLocation()
    }
    
}
extension LocationService : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        newLocation?(.wrong(error))
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.sorted(by: { $0.timestamp > $1.timestamp }).first {
            newLocation?(.success(location))
            currentCoordinate = location.coordinate
            print(currentCoordinate?.latitude , currentCoordinate?.longitude)
        }
     }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch status {
            
        case .notDetermined, .restricted, .denied :
            
            changeLocation?(false)
            break
        
         default:
            changeLocation?(true)
        }
    }
    
}
