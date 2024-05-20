//
//  Event.swift
//  russia losses
//
//  Created by macbook on 23.08.2023.
//

import Foundation


struct lossesEquipment: Codable {

let date: String
let aircraft: Int
let helicopter: Int
let tank: Int
let armoredPersonnelCarrier: Int
let fieldArtillery: Int
let multipleRocketLauncher: Int
let militaryAuto: Int?
let fuelTank: Int?
let drone: Int
let navalShip: Int
let antiAircraftWarfare: Int
let specialEquipment: Int?
let mobileSRBMSystem: Int?
let vehiclesAndFuelTanks: Int?
let cruiseMissiles: Int?
let greatestLossesDirection: String?
    
    enum CodingKeys: String, CodingKey {
        case date
        case aircraft
        case helicopter
        case tank
        case drone
        case armoredPersonnelCarrier = "APC"
        case fieldArtillery = "field artillery"
        case multipleRocketLauncher = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
        case greatestLossesDirection = "greatest losses direction"
    }
    
}
    
    
    
    


