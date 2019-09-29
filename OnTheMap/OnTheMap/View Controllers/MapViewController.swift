//
//  MapViewController.swift
//  OnTheMap
//
//  Created by NTG on 9/22/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var logOut: UIBarButtonItem!
    
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get all student locations
        if StudentLocationModel.studentLocations.isEmpty {
            getLocations()
        }
    }
    
    func getLocations() {
        UdacityClientAPIs.getStudentLocations(amount: 100, completion: handleStudentLocationsResponse(locations:error:))
    }
    
    func handleStudentLocationsResponse(locations: [StudentInformation], error: Error?){
        // if no locations print error
        guard !locations.isEmpty else {
            print(error?.localizedDescription ?? "")
            return
        }
        let studentLocations = StudentLocationModel.studentLocations
        
                for location in studentLocations {
                    // get lat and long values from students
                    let lat = CLLocationDegrees(location.latitude)
                    let long = CLLocationDegrees(location.longitude)
                    // The lat and long are used to create a CLLocationCoordinates2D instance.
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    // get student info
                    let first = location.firstName
                    let last = location.lastName
                    let mediaURL = location.mediaURL
                    // Here we create the annotation and set its coordinate, title, and subtitle properties
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "\(first) \(last)"
                    annotation.subtitle = mediaURL
                    
                    // Finally we place the annotation in an array of annotations.
                    annotations.append(annotation)
                }
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
    }
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = URL(string: view.annotation?.subtitle! ?? "") {
                UIApplication.shared.open(toOpen)
            }
        }
    }

    
    @IBAction func logOut(_ sender: Any) {
        UdacityClientAPIs.logout { (success, error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func refreshMap(_ sender: Any) {
        getLocations()
    }
    
}



        

