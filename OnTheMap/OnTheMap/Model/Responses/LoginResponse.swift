//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by NTG on 9/7/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    
    let account: Account
    let session: SessionResponse
    
}
