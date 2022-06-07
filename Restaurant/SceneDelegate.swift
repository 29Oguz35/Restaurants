//
//  SceneDelegate.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import UIKit
import Moya
import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let locationService = LocationService()
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    var navigationController : UINavigationController?
    
    let decoder = JSONDecoder()
    
    let apiCaller = MoyaProvider<YelpService.DataProvider>()
    
   
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let winScene = (scene as? UIWindowScene) else { return }
        
        
        locationService.newLocation = { result in
            switch result {
                
            case .success(let locationInformation):
                print(locationInformation.coordinate.latitude , locationInformation.coordinate.longitude)
                self.fetchRestaurant(coordinate: locationInformation.coordinate)
            case .wrong(let error):
                print("error occurred \(error.localizedDescription)")
            }
        }
        
        switch locationService.status {
        case .denied, .notDetermined , .restricted :
            let locationVC = storyBoard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
            locationVC?.delegate = self
            window = UIWindow(windowScene: winScene)
            window?.rootViewController = locationVC
        default :
            let navigation = storyBoard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
            window = UIWindow(windowScene: winScene)
            window?.rootViewController = navigation
            navigationController = navigation
           
            locationService.getLocation()
            (navigation?.topViewController as? RestaurantsListTableViewController)?.delegate = self
        }
        window?.makeKeyAndVisible()
        
    }
    func fetchDetails(viewController : UIViewController ,placeID : String) {
        apiCaller.request(.details(id: placeID)) { result in
            switch result {
                
            case .success(let data):
                if let details = try? self.decoder.decode(Details.self, from: data.data) {
                    let restaurantDetails = DetailsViewModel(detail: details)
                    
                    let mealDetailsVC = (viewController as? MealDetailsViewController)
                    
                    mealDetailsVC?.restaurantDetails = restaurantDetails
                    mealDetailsVC?.delegate = self
                }
               
            case .failure(let error):
                print("hata meydana geldi ,\(error.localizedDescription)")
            }
            
        }
    }
    func fetchRestaurant(coordinate: CLLocationCoordinate2D) {
       
        apiCaller.request(.search(lat: coordinate.latitude , long: coordinate.longitude)) { result in
                switch result {
                    
                case .success(let incomingData):
                   
                    let data = try? self.decoder.decode(AllData.self, from: incomingData.data)
                    let restaurantList = data?.businesses.compactMap(RestaurantListViewModel.init).sorted(by: { $0.distance < $1.distance })
                    
                    
                    if let navigation = self.window?.rootViewController as? UINavigationController, let restaurantTableViewController = navigation.topViewController as? RestaurantsListTableViewController {
                        
                        restaurantTableViewController.restaurantList = restaurantList ?? []
                    }else if let navigation1 = self.storyBoard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController {
                        self.navigationController = navigation1
                        navigation1.modalPresentationStyle = .fullScreen
                        
                        self.window?.rootViewController?.present(navigation1, animated: true, completion: {
                            (navigation1.topViewController as? RestaurantsListTableViewController)?.delegate = self
                            (navigation1.topViewController as? RestaurantsListTableViewController)?.restaurantList = restaurantList ?? []
                        })
                    }
                                
                case .failure(let error):
                    print("error occurred \(error.localizedDescription)")
                }
            }
        }
    func fetchComments(viewController : UIViewController ,restaurantID: String) {
        print("yorumları getirdin")
        
        apiCaller.request(.reviews(id: restaurantID)) { result in
            switch result {
                
            case .success(let data):
                if let comments = try? self.decoder.decode(ReviewResponse.self, from: data.data) {
                    print("--------00000********----****\(comments)-*******")
                    
                    let commentsVC = (viewController as! CommentsTableViewController)
                    commentsVC.comments = comments.reviews
                }else {
                    print("veri geldi fakat yorumlar gelmedi")
                }
            case .failure(let error):
                print("An error occurred while fetching comments, \(error.localizedDescription)")
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
extension SceneDelegate : LocationSettings , RestaurantsListAction ,BringCommnetsProtokol {
   
    func toLet() {
        locationService.askPermission()
    }
    func chooseRestaurant(viewController: UIViewController, restaurant: RestaurantListViewModel) {
        fetchDetails(viewController: viewController, placeID: restaurant.id)
    }
    func bring(viewController: UIViewController, restaurantID: String) {
        self.fetchComments(viewController: viewController, restaurantID: restaurantID)
    }
   
}




