//
//  DeteilViewController.swift
//  russia losses
//
//  Created by macbook on 23.08.2023.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - properties -
    let detailView = DetailView()
    
    var personnelEvent: lossesPersonnel?
    var equipmentEvent: lossesEquipment?
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
       
        background()
        setupUI()
        
     
    }
    
    //MARK: - Intents -
    func background() {
        let backgroundView = UIView(frame: view.bounds)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.yellow.cgColor]
        backgroundView.layer.addSublayer(gradientLayer)
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
    }
    
    func setupUI() {
        view.addSubview(detailView.dayOfTheWar)
        view.addSubview(detailView.personnel)
        view.addSubview(detailView.aircraftsLabel)
        view.addSubview(detailView.antiAircraftWarfareLabel)
        view.addSubview(detailView.fieldArtillery)
        view.addSubview(detailView.helicopter)
        view.addSubview(detailView.multipleRocketLauncher)
        view.addSubview(detailView.specialEquipment)
        view.addSubview(detailView.tank)
        view.addSubview(detailView.drone)
        view.addSubview(detailView.vehiclesAndFuelTanks)
        view.addSubview(detailView.armouredPersonnelCarrier)
        view.addSubview(detailView.navalShip)
        view.addSubview(detailView.cruiseMissiles)
        
        NSLayoutConstraint.activate([
            
            detailView.dayOfTheWar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            detailView.dayOfTheWar.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
            detailView.personnel.topAnchor.constraint(equalTo: detailView.dayOfTheWar.bottomAnchor, constant: 20),
            detailView.personnel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detailView.aircraftsLabel.topAnchor.constraint(equalTo: detailView.personnel.bottomAnchor, constant: 8),
            detailView.aircraftsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detailView.antiAircraftWarfareLabel.topAnchor.constraint(equalTo: detailView.aircraftsLabel.bottomAnchor, constant: 8),
            detailView.antiAircraftWarfareLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detailView.fieldArtillery.topAnchor.constraint(equalTo: detailView.antiAircraftWarfareLabel.bottomAnchor, constant: 8),
            detailView.fieldArtillery.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailView.helicopter.topAnchor.constraint(equalTo: detailView.fieldArtillery.bottomAnchor, constant: 8),
            detailView.helicopter.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailView.multipleRocketLauncher.topAnchor.constraint(equalTo: detailView.helicopter.bottomAnchor, constant: 8),
            detailView.multipleRocketLauncher.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailView.specialEquipment.topAnchor.constraint(equalTo: detailView.multipleRocketLauncher.bottomAnchor, constant: 8),
            detailView.specialEquipment.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailView.tank.topAnchor.constraint(equalTo: detailView.specialEquipment.bottomAnchor, constant: 8),
            detailView.tank.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailView.drone.topAnchor.constraint(equalTo: detailView.tank.bottomAnchor, constant: 8),
            detailView.drone.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailView.vehiclesAndFuelTanks.topAnchor.constraint(equalTo: detailView.drone.bottomAnchor, constant: 8),
            detailView.vehiclesAndFuelTanks.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailView.armouredPersonnelCarrier.topAnchor.constraint(equalTo: detailView.vehiclesAndFuelTanks.bottomAnchor, constant: 8),
            detailView.armouredPersonnelCarrier.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailView.navalShip.topAnchor.constraint(equalTo: detailView.armouredPersonnelCarrier.bottomAnchor, constant: 8),
            detailView.navalShip.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailView.cruiseMissiles.topAnchor.constraint(equalTo: detailView.navalShip.bottomAnchor, constant: 8),
            detailView.cruiseMissiles.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
            
        
        ])
        if let personnelEvent = personnelEvent {
            detailView.dayOfTheWar.text = "Date: \(String(describing: personnelEvent.date))"
            detailView.personnel.text = "Personnel died: \(personnelEvent.personnel)"
        }
        detailView.aircraftsLabel.text = "Aircraft: \(equipmentEvent?.aircraft ?? 0)"
        detailView.antiAircraftWarfareLabel.text = "Anti-aircraft warfare: \(equipmentEvent?.antiAircraftWarfare ?? 0)"
        detailView.fieldArtillery.text = "Field artillery: \(equipmentEvent?.fieldArtillery ?? 0)"
        detailView.helicopter.text = "Helicopter: \(equipmentEvent?.helicopter ?? 0)"
        detailView.multipleRocketLauncher.text = "Multiple Rocket Launcher: \(equipmentEvent?.multipleRocketLauncher ?? 0)"
        detailView.specialEquipment.text = "Special equipment: \(equipmentEvent?.specialEquipment ?? 0)"
        detailView.tank.text = "Tanks: \(equipmentEvent?.tank ?? 0)"
        detailView.drone.text = "Drone: \(equipmentEvent?.drone ?? 0)"
        detailView.vehiclesAndFuelTanks.text = "Vehicles and fuel tanks: \(equipmentEvent?.vehiclesAndFuelTanks ?? 0)"
        detailView.armouredPersonnelCarrier.text = "Armoured personnel carrier: \( equipmentEvent?.armoredPersonnelCarrier ?? 0)"
        detailView.navalShip.text = "Naval ship: \(equipmentEvent?.navalShip ?? 0)"
        detailView.cruiseMissiles.text = "Cruise Missiles: \(equipmentEvent?.cruiseMissiles ?? 0)"
    }
}
