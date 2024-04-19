//
//  CheckBox.swift
//  ToDDoList
//
//  Created by Maxim Fedoseenko on 15.04.2024.
//


import UIKit

class CustomCheckBox: UIControl {
    
    private var colorDeafault: UIColor {#colorLiteral(red: 0.3801780305, green: 0.4076312424, blue: 0.4427852878, alpha: 1)}
    private var colorDeafaultSubtitle: UIColor {#colorLiteral(red: 0.8690617109, green: 0.6823187395, blue: 0.007003096398, alpha: 1)}
    
    private lazy var checkBox = makeCustomCheckBox()
    
    private lazy var title = titleCustom()
    private lazy var subtitle = makeSubtitle()
    
    private var checkBoxTab: UIImage {
        return tap ? UIImage(systemName: "checkmark.circle.fill")! : UIImage(systemName: "circle")!
    }
    
    var tap = false {
        didSet {
            update()
        }
    }
    
    func update() {
        checkBox.image = checkBoxTab
        if tap {
            title.textColor = .systemGray
            subtitle.textColor = .systemGray
        } else {
            title.textColor = .black
            subtitle.textColor = colorDeafaultSubtitle
        }
        
    }
    
    func titleText(text: String) {
        title.text = text
        
    }
    
    func subtitleText(text: String) {
        subtitle.text = text
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCheckBox()
        addTarget(self, action: #selector(touch), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        }
    
    @objc func touch() {
        tap.toggle()
    }
    
  
}

//MARK: - SetupCustomCheckBox
extension CustomCheckBox {
    
    private func setupCheckBox() {
        addSubview(checkBox)
        addSubview(title)
        addSubview(subtitle)
        
        NSLayoutConstraint.activate([
            checkBox.widthAnchor.constraint(equalToConstant: 27),
            checkBox.heightAnchor.constraint(equalToConstant: 27),
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 10),
           // title.heightAnchor.constraint(equalToConstant: 25),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            subtitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
        ])
       // checkBox.backgroundColor = .red
        checkBox.image = checkBoxTab
        checkBox.tintColor = colorDeafault
        
        subtitle.textColor = colorDeafaultSubtitle
    }
    
   
    //MakeCustom
    private func makeCustomCheckBox() -> UIImageView {
        let checkBox = UIImageView()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        return checkBox
    }
    
    private func titleCustom() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }
    
    private func makeSubtitle() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }
}


