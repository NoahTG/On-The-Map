//
//  UI VC Extension Errors.swift
//  OnTheMap
//
//  Created by NTG on 9/27/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorAlert(message: String){
        showAlert(title: "Error", message: message)
        
    }

    func showAlert(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            show(alertVC, sender: nil)
        }
    
}

