//
//  CustomTableViewCell.swift
//  russia losses
//
//  Created by macbook on 26.08.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let dateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 3
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.addSubview(cellContentView)
        cellContentView.layer.cornerRadius = 15
        cellContentView.addSubview(dateLabel)
        cellContentView.addSubview(dayLabel)
        
        
        
        
        
        NSLayoutConstraint.activate([
            cellContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            dateLabel.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: cellContentView.centerXAnchor),
            
            dayLabel.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 30),
            dayLabel.centerXAnchor.constraint(equalTo: cellContentView.centerXAnchor),
        ])
    }
    
    
    func configure(with data: lossesPersonnel) {
        dateLabel.text = data.date
        dayLabel.text = " Day \(data.day) of the war"
    }

}
