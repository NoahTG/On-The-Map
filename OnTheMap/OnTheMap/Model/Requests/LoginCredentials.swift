//
//  LoginCredentials.swift
//  OnTheMap
//
//  Created by NTG on 9/27/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

struct LoginCredentials: Codable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
    
}
