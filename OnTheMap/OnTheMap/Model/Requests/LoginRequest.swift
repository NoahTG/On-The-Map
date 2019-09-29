//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by NTG on 9/2/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let udacity: LoginCredentials
    
    enum CodingKeys: String, CodingKey {
        case udacity
    }
    
}
