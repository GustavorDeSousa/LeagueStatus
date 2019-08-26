//
//  LastMatchDTO.swift
//  LeagueStatus
//
//  Created by Gustavo De Sousa on 25/08/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import Foundation

class LastMatchDTO: Codable {
    var matches : [MatchDTO]
}

class MatchDTO: Codable {
    var platformId : String
    var gameId : Int
    var champion : Int
    var queue : Int
    var season : Int
    var timestamp : Int
    var role : String
    var lane : String
}
