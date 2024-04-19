//
//  CheckBoxView.swift
//  ToDDoList
//
//  Created by Maxim Fedoseenko on 15.04.2024.
//

import UIKit

class CheckBoxView: UITableViewCell {

 let checkBox = CustomCheckBox()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tableViewCell()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tableViewCell() {
        contentView.addSubview(checkBox)
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        //checkBox.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            checkBox.topAnchor.constraint(equalTo: contentView.topAnchor),
            checkBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            checkBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            checkBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
}
