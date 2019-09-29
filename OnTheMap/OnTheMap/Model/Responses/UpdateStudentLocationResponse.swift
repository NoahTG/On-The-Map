//
//  UpdateStudentLocationResponse.swift
//  OnTheMap
//
//  Created by NTG on 9/10/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

struct UpdateStudentLocationResponse: Codable {
    let updatedAt: String
}

class UpdateStudentLocation {
    static var studentLocation: StudentInformation!
}
