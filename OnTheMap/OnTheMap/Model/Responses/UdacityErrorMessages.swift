//
//  UdacityErrorMessages.swift
//  OnTheMap
//
//  Created by NTG on 9/1/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

struct UdacityErrorMessages: Codable {
    let statusCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case errorMessage = "error"
    }
    
}

extension UdacityErrorMessages: Error {
    
    var errorDescription: String? {
        return errorMessage
    }
}
