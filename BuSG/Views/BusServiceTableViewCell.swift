//
//  BusStopCell.swift
//  Navigem
//
//  Created by Wei Da on 7/12/20.
//

import UIKit

class BusServiceTableViewCell: UITableViewCell {
    
    var busStopIcons = UIImageView()
    var busStopLabel = UILabel()
    var busSymbol = UIImage(systemName: "bus.fill")
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(busStopIcons)
        addSubview(busStopLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraintLeft()
        setImageConstraintRight()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //func set(busStop: BusStop)
    func set(busNumber: String) {
        busStopLabel.text = busNumber
        busStopIcons.image = busSymbol
    }
    
    func configureImageView() {
        busStopIcons.layer.cornerRadius = 10
        busStopIcons.clipsToBounds = true
    }

    func configureTitleLabel() {
        busStopLabel.numberOfLines = 0
        busStopLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraintLeft() {
        busStopIcons.translatesAutoresizingMaskIntoConstraints = false
        busStopIcons.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        busStopIcons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        busStopIcons.heightAnchor.constraint(equalToConstant: 40).isActive = true
        busStopIcons.widthAnchor.constraint(equalTo: busStopIcons.heightAnchor, multiplier: 1/1).isActive = true
    }

    func setImageConstraintRight() {
        busStopIcons.translatesAutoresizingMaskIntoConstraints = false
        busStopIcons.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        busStopIcons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        busStopIcons.heightAnchor.constraint(equalToConstant: 40).isActive = true
        busStopIcons.widthAnchor.constraint(equalTo: busStopIcons.heightAnchor, multiplier: 1/1).isActive = true
    }
    
    func setTitleLabelConstraints() {
        busStopLabel.translatesAutoresizingMaskIntoConstraints = false
        busStopLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        busStopLabel.leadingAnchor.constraint(equalTo: busStopIcons.trailingAnchor, constant: 20).isActive = true
        busStopLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        busStopLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
}
