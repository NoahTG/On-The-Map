//
//  AddLocationMapViewController.swift
//  OnTheMap
//
//  Created by NTG on 9/27/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit
import MapKit


class AddLocationMapViewController: UIViewController, MKMapViewDelegate {
    
    var location: MKPointAnnotation!
    var selectedStudentLocation: StudentInformation!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let location = location {
            mapView.addAnnotation(location)
            var region: MKCoordinateRegion = mapView.region
            region.center.latitude = location.coordinate.latitude
            region.center.longitude = location.coordinate.longitude
            region.span.latitudeDelta = 0.05
            region.span.longitudeDelta = 0.05
            mapView.setRegion(region, animated: true)
            
            UdacityClientAPIs.getUserInfo(completion: {(response, error)
                in
                if let user = response{
                    StudentLocationModel.selectedStudentLocation = StudentInformation(objectId:  StudentLocationModel.selectedStudentLocation != nil ? (StudentLocationModel.selectedStudentLocation.objectId ) : "", uniqueKey: UUID().uuidString, firstName: user.firstName, lastName: user.lastName, mapString: location.title ?? "", mediaURL: location.subtitle ?? "", latitude:  Float(location.coordinate.latitude) , longitude: Float(location.coordinate.longitude) , createdAt: "", updatedAt: "")
                }else{
                   self.showErrorAlert(message: "User data is invalid. Failed to process request")
                }
            })
        }
        
    }
    
    
    
    @IBAction func postLocation(_ sender: Any) {
        if let newLocation = StudentLocationModel.selectedStudentLocation {
            UdacityClientAPIs.postStudentLocation(studentLocation: newLocation, completion: { (response, error)
                in
                if response {
                    self.showAlert(title: "Success", message: "Student location added")
                } else {
                    self.showErrorAlert(message: "The location could not be added. Please try again.")
                }
            })
        }
    
    }
    
    
}
