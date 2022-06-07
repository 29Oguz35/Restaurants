//
//  MealDetailsView.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import Foundation
import UIKit
import MapKit

@IBDesignable class MealDetailsView: BasicView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBAction func handleControl(_ sender: UIPageControl) {
        
    }
    
}
