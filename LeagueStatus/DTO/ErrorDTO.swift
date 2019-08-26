//
//  ErrorDTO.swift
//  LeagueStatus
//
//  Created by Gustavo De Sousa on 25/08/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import Foundation

class ErrorStatusDTO: Codable {
    var status : [ErrorDTO]
}

class ErrorDTO: Codable {
    var message : String
    var status_code :Int
}
