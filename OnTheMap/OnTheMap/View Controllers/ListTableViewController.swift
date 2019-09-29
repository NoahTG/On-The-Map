//
//  ListTableViewController.swift
//  OnTheMap
//
//  Created by NTG on 9/22/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController{
    
    
    @IBOutlet var tableViewLocations: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // get all student locations
        if StudentLocationModel.studentLocations.isEmpty {
            getLocations()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewLocations.reloadData()
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
        //assign all locations from students
        StudentLocationModel.studentLocations = locations
        tableViewLocations.reloadData()
    }
    
    
    @IBAction func refreshTable(_ sender: Any) {
        getLocations()
    }
    
    @IBAction func logOut(_ sender: Any) {
        UdacityClientAPIs.logout { (success, error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
   
    
}

extension ListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: Set the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of prompts in the storyNode (The 2 is just a place holder)
        return StudentLocationModel.studentLocations.count;
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Dequeue a cell and populate it with student location info
        let cell = tableViewLocations.dequeueReusableCell(withIdentifier: "ListViewCell")!
        
        let location = StudentLocationModel.studentLocations[indexPath.row]
        
        cell.textLabel?.text = "\(location.firstName) \(location.lastName)"
        cell.detailTextLabel?.text = StudentLocationModel.studentLocations[indexPath.row].mediaURL
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let location = StudentLocationModel.studentLocations[indexPath.row]

        if let toOpen = URL(string: location.mediaURL) {
            UIApplication.shared.open(toOpen)
        // push VC
        tableView.deselectRow(at: indexPath, animated: true)

        }
    
    }
}
