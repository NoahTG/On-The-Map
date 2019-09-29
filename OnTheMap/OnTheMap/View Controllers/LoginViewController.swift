//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by NTG on 9/1/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAway()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    /// Creates a tap gesture recognizer that closes the keyboard when an outside view is tapped
    func hideKeyboardWhenTappedAway() {
        //Looks for single tap event that closes keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        // set false so all touch events are sent to the view
        tap.cancelsTouchesInView = false
        // calls tap event when a tap is recognized
        self.view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func performLogin(_ sender: Any) {
        guard let username = emailTextField.text, let password = passwordTextField.text else {
            self.showErrorAlert(message: "Error: Missing login credentials)(message:")
            return
        }
        setLoggingIn(true)
        UdacityClientAPIs.login(username: username, password: password, completion: handleSessionReponse(success:error:))
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
    
    func handleSessionReponse(success: Bool, error: Error?){
        setLoggingIn(false)
        if success {
            print("Session: " + UdacityClientAPIs.Auth.sessionId)
            performSegue(withIdentifier: "loginSuccess", sender: nil)
        } else {
            self.showErrorAlert(message: error?.localizedDescription ?? "")
        }
    }
 

    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(UdacityClientAPIs.Endpoints.udacitySignUp.url)
    }
    
}

