//
//  LocationView.swift
//  Restaurant
//
//  Created by naruto kurama on 30.05.2022.
//

import UIKit

@IBDesignable class LocationView: BasicView {

    @IBOutlet weak var btnAllow: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    
    var allowed : (() -> Void)?
    
    @IBAction func btnAllowClicked(_ sender: UIButton) {
        allowed?()
    }
    
    @IBAction func btnRejectClicked(_ sender: UIButton) {
    }
}
