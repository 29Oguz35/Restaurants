//
//  MealDetailsViewController.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import UIKit
import MapKit
import CoreLocation

class MealDetailsViewController: UIViewController {
    
    @IBOutlet weak var mealDetailsView: MealDetailsView!
    
    var delegate : BringCommnetsProtokol?
    
    var restaurantDetails : DetailsViewModel? {
        didSet {
            configure()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mealDetailsView.collectionView.register(MealDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "RestaurantImage")
        mealDetailsView.collectionView.delegate = self
        mealDetailsView.collectionView.dataSource = self
    }
    
    func configure() {
        mealDetailsView.lblScore.text = restaurantDetails?.score
        mealDetailsView.lblLocation.text = restaurantDetails?.phoneNumber
        mealDetailsView.lblHour.text = restaurantDetails?.closed
        mealDetailsView.lblPrice.text = restaurantDetails?.price
        
        mealDetailsView.collectionView.reloadData()
        showMap()
        title = restaurantDetails?.restaurantName
    }
    func showMap() {
        
        if let cordinate = restaurantDetails?.coordinate {
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: cordinate, span: span)
            mealDetailsView.mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = cordinate
            annotation.title = restaurantDetails?.restaurantName
            mealDetailsView.mapView.addAnnotation(annotation)
            
        }
    }
    
    @IBAction func btnShowCommentClicked(_ sender: UIButton) {
        
        guard let commentsVC = storyboard?.instantiateViewController(withIdentifier: "CommentsTableViewController") else { return }
        navigationController?.pushViewController(commentsVC, animated: true)
        
        delegate?.bring(viewController: commentsVC, restaurantID: restaurantDetails!.id)
    }
}
extension MealDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantDetails?.imageRestaurants.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantImage", for: indexPath) as! MealDetailsCollectionViewCell
        if let imgURL = restaurantDetails?.imageRestaurants[indexPath.row] {
            cell.imgRestaurant.af.setImage(withURL: imgURL)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        mealDetailsView.pageControl.currentPage = indexPath.row
    }
}
protocol BringCommnetsProtokol {
    func bring(viewController : UIViewController, restaurantID : String)
}
