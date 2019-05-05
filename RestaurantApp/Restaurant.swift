//
//  Restaurant.swift
//  RestaurantApp
//
//  Created by Anna Hacksell Lindberg on 2019-04-14.
//  Copyright © 2019 Anna Hacksell Lindberg. All rights reserved.
//

import Foundation
import MapKit

class Restaurant: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let openingHours: String
    let food: String
    let sunLocation: String
    
    
    init(title: String, coordinate: CLLocationCoordinate2D, openingHours: String, food: String, sunLocation: String){
        self.title = title
        self.coordinate = coordinate
        self.openingHours = openingHours
        self.food = food
        self.sunLocation = sunLocation
        
        
        super.init()
    }
    
    
    
    
}
