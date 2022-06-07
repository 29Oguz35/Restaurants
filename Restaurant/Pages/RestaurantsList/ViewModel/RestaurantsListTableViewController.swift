//
//  RestaurantsListTableViewController.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import UIKit

protocol RestaurantsListAction {
    func chooseRestaurant(viewController: UIViewController ,restaurant : RestaurantListViewModel)
}


class RestaurantsListTableViewController: UITableViewController {
    
    var delegate : RestaurantsListAction?
    
    var restaurantList = [RestaurantListViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return restaurantList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestoranCell", for: indexPath) as! RestaurantsTableViewCell
        let restaurant = restaurantList[indexPath.row]
        
        cell.configure(restaurant: restaurant)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MealDetailsViewController") else {return}
          
          navigationController?.pushViewController(detailsVC, animated: true)
          let selectedRestaurant = restaurantList[indexPath.row]
        delegate?.chooseRestaurant(viewController: detailsVC, restaurant: selectedRestaurant)
          
      }
  
}
