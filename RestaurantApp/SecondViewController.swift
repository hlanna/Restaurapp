//
//  SecondViewController.swift
//  RestaurantApp
//
//  Created by Anna Hacksell Lindberg on 2019-04-14.
//  Copyright © 2019 Anna Hacksell Lindberg. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var restaurant: Restaurant? = nil
    
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var sunLocation: UILabel!
    @IBOutlet weak var food: UILabel!
    @IBOutlet weak var openingHours: UILabel!
    @IBOutlet weak var restaurantTitle: UILabel!
    @IBOutlet weak var openingHoursHeader: UILabel!
    @IBOutlet weak var restaurantTitleHeader: UILabel!
    @IBOutlet weak var foodHeader: UILabel!
    @IBOutlet weak var sunLocationHeader: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //restaurantTitle.text = restaurantTitleString
        restaurantTitle.text = restaurant?.title
        openingHours.text = restaurant?.openingHours
        food.text = restaurant?.food
        sunLocation.text = restaurant?.sunLocation
        openingHoursHeader.text = NSLocalizedString("Opening Hours", comment: "")
        restaurantTitleHeader.text = NSLocalizedString("Restaurant Title", comment: "")
        foodHeader.text = NSLocalizedString("Food", comment: "")
        sunLocationHeader.text = NSLocalizedString("Sun Location", comment: "")
    }

}
