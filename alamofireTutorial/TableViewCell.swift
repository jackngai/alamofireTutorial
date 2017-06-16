//
//  TableViewCell.swift
//  alamofireTutorial
//
//  Created by Jack Ngai on 6/16/17.
//  Copyright © 2017 Jack Ngai. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var trackNameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(trackNameLabel)
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        trackNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }

}
