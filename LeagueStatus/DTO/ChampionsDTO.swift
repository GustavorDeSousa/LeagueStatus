//
//  ChampionsDTO.swift
//  LeagueStatus
//
//  Created by Gustavo De Sousa on 26/08/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import Foundation

struct Champions: Codable {
    let type    : String
    let format  : String
    let version : String
    let data    : [Info]
}

struct Champion: Codable {
    let allChamp: [Info]
}

struct Info: Codable {
    let version : String
    let id      : String
    let key     : String
    let name    : String
    let title   : String
    let blurb   : String
    let image   : ImageChampion
    let tags    : [String]
    let partype : String
}

struct AtributesChampion: Codable {
    let attack      : String
    let defense     : String
    let magic       : String
    let difficulty  : String
}

struct ImageChampion: Codable {
    let full    : String
    let sprite  : String
    let group   : String
    let x       : Int
    let y       : Int
    let w       : Int
    let h       : Int
}

struct Stats: Codable {
    let hp                      : Double
    let hpperlevel              : Double
    let mp                      : Double
    let mpperlevel              : Double
    let movespeed               : Double
    let armor                   : Double
    let armorperlevel           : Double
    let spellblock              : Double
    let spellblockperlevel      : Double
    let attackrange             : Double
    let hpregen                 : Double
    let hpregenperlevel         : Double
    let mpregen                 : Double
    let mpregenperlevel         : Double
    let crit                    : Double
    let critperlevel            : Double
    let attackdamage            : Double
    let attackdamageperlevel    : Double
    let attackspeedperlevel     : Double
    let attackspeed             : Double
    let h                       : Double
}
