//
//  ViewController.swift
//  russia losses
//
//  Created by macbook on 23.08.2023.
//

import UIKit




class ElementListViewController: UIViewController {
    
    //MARK: - properties -
    let elementListView = ElementListView()
    let tableView = UITableView()
    let lossesEquipmentArray: [lossesEquipment] = Bundle.main.decode(file: "russia_losses_equipment.json")
    let lossesPersonnelArray: [lossesPersonnel] = Bundle.main.decode(file: "russia_losses_personnel.json")
    var filteredLossesPersonnelArray: [lossesPersonnel] = []
    private var searchText: String = ""
    private var isMenuOpen = false
    var selectedLosses: lossesPersonnel?
    
    
    var allEquipmentLosses: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.aircraft +
        lastDayLosses.helicopter +
        lastDayLosses.tank +
        lastDayLosses.armoredPersonnelCarrier +
        lastDayLosses.fieldArtillery +
        lastDayLosses.multipleRocketLauncher +
        (lastDayLosses.militaryAuto ?? 0) +
        (lastDayLosses.fuelTank ?? 0) +
        lastDayLosses.drone +
        lastDayLosses.navalShip +
        lastDayLosses.antiAircraftWarfare +
        (lastDayLosses.specialEquipment ?? 0) +
        (lastDayLosses.mobileSRBMSystem ?? 0) +
        (lastDayLosses.vehiclesAndFuelTanks ?? 0) +
        (lastDayLosses.cruiseMissiles ?? 0)
    }
    
    var allPersonalLosses: Int {
        guard let lastDayLosses = lossesPersonnelArray.last else {
            return 0
        }
        return lastDayLosses.personnel
    }
    
    var AircraftsNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.aircraft
    }
    
    var antiAircraftWarfareNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.antiAircraftWarfare
    }
    
    var fieldArtilleryNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.fieldArtillery
    }
    
    var helicopterNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.helicopter
    }
    
    var multipleRocketLauncherNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.multipleRocketLauncher
    }
    
    var specialEquipmentNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.specialEquipment ?? 0
    }
    
    var tanksNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.tank
    }
    
    var droneNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.drone
    }
    
    var vehiclesAndFuelTanksNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.vehiclesAndFuelTanks ?? 0
    }
    
    var armouredPersonnelCarrierNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.armoredPersonnelCarrier
    }
    
    var navalShipNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.navalShip
    }
    
    var cruiseMissilesNumber: Int {
        guard let lastDayLosses = lossesEquipmentArray.last else {
            return 0
        }
        return lastDayLosses.cruiseMissiles ?? 0
    }
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        elementListView.search.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        hideKeyboard()
        setupUI()
        tableViewSettings()
    }
    
    //MARK: - Intents -
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        elementListView.search.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            
            UIView.animate(withDuration: 0.3) {
                self.elementListView.menuView.frame.origin.y -= keyboardHeight
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            
            UIView.animate(withDuration: 0.3) {
                self.elementListView.menuView.frame.origin.y += keyboardHeight
            }
        }
    }
    
    func setupUI() {
        let backgroundView = UIView(frame: view.bounds)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.yellow.cgColor]
        backgroundView.layer.addSublayer(gradientLayer)
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
        
        view.addSubview(elementListView.menuButton)
        view.addSubview(elementListView.dayOfTheWar)
        view.addSubview(elementListView.titleLossesBackground)
        elementListView.titleLossesBackground.addSubview(elementListView.titleLossesLabel)
        view.addSubview(elementListView.totalEquipmentBackground)
        elementListView.totalEquipmentBackground.addSubview(elementListView.totalEquipmentLosses)
        view.addSubview(elementListView.theDeathTollBackground)
        elementListView.theDeathTollBackground.addSubview(elementListView.theDeathToll)
        view.addSubview(elementListView.numberTotalEquipmentLosses)
        view.addSubview(elementListView.numberTheDeathToll)
        view.addSubview(elementListView.aircraftsLabel)
        view.addSubview(elementListView.antiAircraftWarfareLabel)
        view.addSubview(elementListView.fieldArtillery)
        view.addSubview(elementListView.helicopter)
        view.addSubview(elementListView.multipleRocketLauncher)
        view.addSubview(elementListView.specialEquipment)
        view.addSubview(elementListView.tank)
        view.addSubview(elementListView.drone)
        view.addSubview(elementListView.vehiclesAndFuelTanks)
        view.addSubview(elementListView.armouredPersonnelCarrier)
        view.addSubview(elementListView.navalShip)
        view.addSubview(elementListView.cruiseMissiles)
        elementListView.menuButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        elementListView.menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            elementListView.menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            elementListView.menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            elementListView.menuButton.widthAnchor.constraint(equalToConstant: 120),
            
            elementListView.titleLossesBackground.widthAnchor.constraint(equalToConstant: 100),
            elementListView.titleLossesBackground.heightAnchor.constraint(equalToConstant: 60),
            elementListView.titleLossesBackground.topAnchor.constraint(equalTo: elementListView.menuButton.bottomAnchor, constant: 8),
            elementListView.titleLossesBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            elementListView.titleLossesBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            elementListView.titleLossesLabel.topAnchor.constraint(equalTo: elementListView.titleLossesBackground.topAnchor, constant: 8),
            elementListView.titleLossesLabel.bottomAnchor.constraint(equalTo: elementListView.titleLossesBackground.bottomAnchor, constant: -8),
            elementListView.titleLossesLabel.leftAnchor.constraint(equalTo: elementListView.titleLossesBackground.leftAnchor, constant: 8),
            elementListView.titleLossesLabel.rightAnchor.constraint(equalTo: elementListView.titleLossesBackground.rightAnchor, constant: -8),
            
            elementListView.totalEquipmentBackground.widthAnchor.constraint(equalToConstant: 150),
            elementListView.totalEquipmentBackground.heightAnchor.constraint(equalToConstant: 70),
            elementListView.totalEquipmentBackground.topAnchor.constraint(equalTo: elementListView.titleLossesBackground.bottomAnchor, constant: 8),
            elementListView.totalEquipmentBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            
            elementListView.totalEquipmentLosses.topAnchor.constraint(equalTo: elementListView.totalEquipmentBackground.topAnchor, constant: 8),
            elementListView.totalEquipmentLosses.centerXAnchor.constraint(equalTo: elementListView.totalEquipmentBackground.centerXAnchor),
            
            elementListView.numberTotalEquipmentLosses.centerXAnchor.constraint(equalTo: elementListView.totalEquipmentLosses.centerXAnchor),
            elementListView.numberTotalEquipmentLosses.topAnchor.constraint(equalTo: elementListView.totalEquipmentLosses.bottomAnchor, constant: 8),
            
            elementListView.theDeathTollBackground.widthAnchor.constraint(equalToConstant: 150),
            elementListView.theDeathTollBackground.heightAnchor.constraint(equalToConstant: 70),
            elementListView.theDeathTollBackground.topAnchor.constraint(equalTo: elementListView.titleLossesBackground.bottomAnchor, constant: 8),
            elementListView.theDeathTollBackground.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            
            elementListView.theDeathToll.topAnchor.constraint(equalTo: elementListView.theDeathTollBackground.topAnchor, constant: 8),
            elementListView.theDeathToll.centerXAnchor.constraint(equalTo: elementListView.theDeathTollBackground.centerXAnchor),
            
            elementListView.numberTheDeathToll.centerXAnchor.constraint(equalTo: elementListView.theDeathToll.centerXAnchor),
            elementListView.numberTheDeathToll.topAnchor.constraint(equalTo: elementListView.theDeathToll.bottomAnchor, constant: 8),
            
            elementListView.dayOfTheWar.topAnchor.constraint(equalTo: elementListView.theDeathTollBackground.bottomAnchor, constant: 20),
            elementListView.dayOfTheWar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.aircraftsLabel.topAnchor.constraint(equalTo: elementListView.dayOfTheWar.bottomAnchor, constant: 8),
            elementListView.aircraftsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.antiAircraftWarfareLabel.topAnchor.constraint(equalTo: elementListView.aircraftsLabel.bottomAnchor, constant: 8),
            elementListView.antiAircraftWarfareLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.fieldArtillery.topAnchor.constraint(equalTo: elementListView.antiAircraftWarfareLabel.bottomAnchor, constant: 8),
            elementListView.fieldArtillery.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.helicopter.topAnchor.constraint(equalTo: elementListView.fieldArtillery.bottomAnchor, constant: 8),
            elementListView.helicopter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.multipleRocketLauncher.topAnchor.constraint(equalTo: elementListView.helicopter.bottomAnchor, constant: 8),
            elementListView.multipleRocketLauncher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.specialEquipment.topAnchor.constraint(equalTo: elementListView.multipleRocketLauncher.bottomAnchor, constant: 8),
            elementListView.specialEquipment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.tank.topAnchor.constraint(equalTo: elementListView.specialEquipment.bottomAnchor, constant: 8),
            elementListView.tank.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.drone.topAnchor.constraint(equalTo: elementListView.tank.bottomAnchor, constant: 8),
            elementListView.drone.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.vehiclesAndFuelTanks.topAnchor.constraint(equalTo: elementListView.drone.bottomAnchor, constant: 8),
            elementListView.vehiclesAndFuelTanks.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.armouredPersonnelCarrier.topAnchor.constraint(equalTo: elementListView.vehiclesAndFuelTanks.bottomAnchor, constant: 8),
            elementListView.armouredPersonnelCarrier.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.navalShip.topAnchor.constraint(equalTo: elementListView.armouredPersonnelCarrier.bottomAnchor, constant: 8),
            elementListView.navalShip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            elementListView.cruiseMissiles.topAnchor.constraint(equalTo: elementListView.navalShip.bottomAnchor, constant: 8),
            elementListView.cruiseMissiles.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        elementListView.menuButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        elementListView.numberTotalEquipmentLosses.text = "\(allEquipmentLosses)"
        elementListView.numberTheDeathToll.text = "\(allPersonalLosses)"
        elementListView.dayOfTheWar.text = "Day \(lossesEquipmentArray.count + 1) of the war"
        elementListView.aircraftsLabel.text = "Aircraft: \(AircraftsNumber)"
        elementListView.antiAircraftWarfareLabel.text = "Anti-aircraft warfare: \(antiAircraftWarfareNumber)"
        elementListView.fieldArtillery.text = "Field Artillery: \(fieldArtilleryNumber)"
        elementListView.helicopter.text = "Helicopters: \(helicopterNumber)"
        elementListView.multipleRocketLauncher.text = "Multiple Rocket Launcher: \(multipleRocketLauncherNumber)"
        elementListView.specialEquipment.text = "Special Equipment: \(specialEquipmentNumber)"
        elementListView.tank.text = "Tanks: \(tanksNumber)"
        elementListView.drone.text = "Drones: \(droneNumber)"
        elementListView.vehiclesAndFuelTanks.text = "Vehicles and fuel tanks: \(vehiclesAndFuelTanksNumber)"
        elementListView.armouredPersonnelCarrier.text = "Armoured personnel carrier: \(armouredPersonnelCarrierNumber)"
        elementListView.navalShip.text = "Naval ship: \(navalShipNumber)"
        elementListView.cruiseMissiles.text = "Cruise missiles: \(cruiseMissilesNumber)"
        
    }
    
    @objc func toggleMenu() {
        if isMenuOpen {
            closeMenu()
        } else {
            openMenu()
        }
    }
    
    
    private func openMenu() {
        isMenuOpen = true
        elementListView.menuButton.setTitle("Close menu", for: .normal)
        
        UIView.animate(withDuration: 0.7) {
            self.elementListView.menuView.frame.origin.y = self.view.bounds.height - 300
        }
    }
    
    private func closeMenu() {
        elementListView.menuView.removeFromSuperview()
        isMenuOpen = false
        elementListView.menuButton.setTitle("Open menu", for: .normal)
        
        UIView.animate(withDuration: 0.7) {
            self.elementListView.menuView.frame.origin.y = self.view.bounds.height
        } completion: { _ in
            self.elementListView.menuView.removeFromSuperview()
        }
    }
    
    
    @objc func showMenu() {
        elementListView.menuView.frame = CGRect(x: 0, y: view.bounds.height - 300, width: view.bounds.width, height: 300)
        view.addSubview(elementListView.menuView)
    }
    
    func tableViewSettings() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        elementListView.menuView.addSubview(tableView)
        elementListView.menuView.addSubview(elementListView.search)
        
        let constraints = [
            elementListView.search.topAnchor.constraint(equalTo: elementListView.menuView.topAnchor),
            elementListView.search.leadingAnchor.constraint(equalTo: elementListView.menuView.leadingAnchor),
            elementListView.search.trailingAnchor.constraint(equalTo: elementListView.menuView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: elementListView.search.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: elementListView.menuView.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: elementListView.menuView.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: elementListView.menuView.bottomAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(constraints)
        elementListView.menuButton.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
    }
}

extension ElementListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchText.isEmpty ? lossesPersonnelArray.count : filteredLossesPersonnelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        var event = lossesPersonnelArray[indexPath.row]
        cell.contentView.backgroundColor = UIColor.black
        
        if searchText.isEmpty {
            event = lossesPersonnelArray[indexPath.row]
        } else {
            event = filteredLossesPersonnelArray[indexPath.row]
        }
        cell.configure(with: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchText.isEmpty {
            selectedLosses = lossesPersonnelArray[indexPath.row]
        } else {
            selectedLosses = filteredLossesPersonnelArray[indexPath.row]
        }
        
        let selectedEventToo = lossesEquipmentArray[indexPath.row]
        
        let detailViewController = DetailViewController()
        detailViewController.personnelEvent = selectedLosses
        detailViewController.equipmentEvent = selectedEventToo
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topOffset = 0
        let bottomOffset = max(0, scrollView.contentSize.height - scrollView.bounds.size.height)

        scrollView.contentOffset.y = CGFloat(
            min(
                max(scrollView.contentOffset.y, CGFloat(topOffset)),
                bottomOffset
            )
        )
    }
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> [T] {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project!")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not find \(file) in the project!")
        }
        
        let decoder = JSONDecoder()
        
        guard let load = try? decoder.decode([T].self, from: data) else {
            fatalError("Could not find \(file) in the project!")
        }
        return load
    }
}

extension ElementListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        if searchText.isEmpty {
            filteredLossesPersonnelArray = []
        } else {
            filteredLossesPersonnelArray = lossesPersonnelArray.filter { event in
                event.date.contains(searchText)
            }
        }
        
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.keyboardType = .numbersAndPunctuation
        NotificationCenter.default.post(name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        NotificationCenter.default.post(name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

