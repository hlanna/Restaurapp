//
//  ViewController.swift
//  RestaurantApp
//
//  Created by Anna Hacksell Lindberg on 2019-04-14.
//  Copyright © 2019 Anna Hacksell Lindberg. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase


class ViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var restaurapp: UILabel!
    var restaurant: Restaurant? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func buttonClick(sender: UIButton, forEvent event: UIEvent){
        performSegue(withIdentifier: "detailedSegue", sender: self)
    }
   
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
        
        let db = Firestore.firestore()
        db.collection("restaurants").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                   // print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let title = data["title"] as! String
                    let location = data["location"] as! GeoPoint
                    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                    let openingHours = data["openingHours"] as! String
                    let food = data["food"] as! String
                    let sunLocation = data["sunLocation"] as! String
                    let restaurant = Restaurant(title: title, coordinate: coordinate , openingHours: openingHours, food: food, sunLocation: sunLocation)
                   
                    self.mapView.addAnnotation(restaurant)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")

        let location = locations.first!
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(coordinateRegion, animated: true)
        
        locationManager.stopUpdatingLocation()
    }
    

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        restaurant = view.annotation as? Restaurant
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier: "identifier")
        annotationView.isEnabled = true
        annotationView.canShowCallout = true
        
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        annotationView.rightCalloutAccessoryView = button
        
        return annotationView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc: SecondViewController = segue.destination as! SecondViewController
        
        vc.restaurant = restaurant
        
    }
}



