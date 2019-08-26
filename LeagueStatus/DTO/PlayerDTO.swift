//
//  PlayerDTO.swift
//  LeagueOfLegndsAPI
//
//  Created by Gustavo De Sousa on 24/08/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class PlayerDTO: Codable {
    var accountId : String
    var name : String
    var profileIconId : Int
    var summonerLevel :Int
}
