//
//  LocationViewController.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import UIKit

protocol LocationSettings {
    func toLet()
}

class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView : LocationView!
    
    var delegate : LocationSettings?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationView.allowed = {
            self.delegate?.toLet()
        }
        
       
        
    }
    

   

}
