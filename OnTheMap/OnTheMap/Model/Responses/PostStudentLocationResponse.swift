//
//  PostStudentLocationResponse.swift
//  OnTheMap
//
//  Created by NTG on 9/8/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

struct PostStudentLocationResponse: Codable {
    
    let createdAt: String
    let objectId: String
}

class PostStudentLocation {
    
    static var studentLocation: StudentInformation!
}

