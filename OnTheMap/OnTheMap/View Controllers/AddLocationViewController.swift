//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by NTG on 9/25/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    
    let annotation = MKPointAnnotation()

    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAway()
        
    }
    
    func hideKeyboardWhenTappedAway() {
        //Looks for single tap event that closes keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        // set false so all touch events are sent to the view
        tap.cancelsTouchesInView = false
        // calls tap event when a tap is recognized
        self.view.addGestureRecognizer(tap)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func findLocation(_ sender: Any) {
        guard isDataValid() else {return}
        
        let newLocation = location.text!
        let newURL = url.text!
        
        let url = URL(string: newURL)

        if let url = url, UIApplication.shared.canOpenURL(url){
            isGeoCoding(true)
            CLGeocoder().geocodeAddressString(newLocation, completionHandler: {(placeMarks, error)
                in
                self.isGeoCoding(false)
                if let placeMark = placeMarks?[0] {
                    self.annotation.coordinate = (placeMark.location?.coordinate)!
                    self.annotation.title = newLocation
                    self.annotation.subtitle = newURL
                    
                    self.performSegue(withIdentifier: "findLocation", sender: nil)
                }else{
                    self.showErrorAlert(message: error?.localizedDescription ?? "")
                }
            })
        }
    }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "findLocation"{
            let addLocationMapVC = segue.destination as! AddLocationMapViewController
            addLocationMapVC.location = annotation
        }
    }
    
    
    
    func isDataValid() -> Bool {
        if (location.text!.isEmpty) {
            showErrorAlert(message: "Please enter a valid address")
            return false
        } else if (url.text!.isEmpty){
            showErrorAlert(message: "Please enter a valid URL")
            return false
        }
        return true
    }
    
    
    func isGeoCoding(_ geocoding: Bool) {
        if geocoding {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        location.isEnabled = !geocoding
        url.isEnabled = !geocoding
        findLocationButton.isEnabled = !geocoding
    }
    
}

