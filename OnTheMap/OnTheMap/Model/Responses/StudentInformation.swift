//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by NTG on 9/1/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
    
    var objectId: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Float
    var longitude: Float
    var createdAt: String
    var updatedAt: String
    
    
    enum CodingKeys: String, CodingKey {
        case objectId
        case uniqueKey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude
        case longitude
        case createdAt
        case updatedAt
    }
    
    
}



