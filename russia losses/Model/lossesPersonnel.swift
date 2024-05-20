//
//  lossesPersonnel.swift
//  russia losses
//
//  Created by macbook on 26.08.2023.
//

import Foundation

struct lossesPersonnel: Codable {
    let date: String
    let day, personnel: Int
    let moviePersonnel: Personnel
    let pow: Int?

    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case moviePersonnel = "personnel*"
        case pow = "POW"
    }
}

enum Personnel: String, Codable {
    case about = "about"
    case more = "more"
}


