//
//  UserInfoResponse.swift
//  OnTheMap
//
//  Created by NTG on 9/9/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

struct UserInfoResponse: Codable {
    
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        
        case firstName = "first_name"
        case lastName = "last_name"
        
    }
    
}
