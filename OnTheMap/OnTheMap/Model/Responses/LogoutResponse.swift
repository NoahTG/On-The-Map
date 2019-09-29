//
//  LogoutResponse.swift
//  OnTheMap
//
//  Created by NTG on 9/10/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

struct LogoutResponse: Codable {
    
    let account: Account
    let session: SessionResponse
    
}
