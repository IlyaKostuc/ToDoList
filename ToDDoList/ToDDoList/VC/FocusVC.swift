//
//  FocusVC.swift
//  lesson15(TooDooList)
//
//  Created by Maxim Fedoseenko on 10.04.2024.
//

import UIKit

class FocusVC: UIViewController {

    private var colorDeafault: UIColor {#colorLiteral(red: 0.3801780305, green: 0.4076312424, blue: 0.4427852878, alpha: 1)}
    
    private lazy var tableView = makeTableView()
    
   
    private var notes: [String] = []
    
    private var notesSubtitle: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
        
        view.addSubview(button())
        tableView.register(CheckBoxView.self, forCellReuseIdentifier: "CheckBoxView")
    }

}

//MARK: - SetupFocusVC
extension FocusVC {
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .white  
        
        tableView.sectionHeaderHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let deleteButtonCustom = UIImage(systemName: "minus.circle")
        let deleteButton = UIBarButtonItem(image: deleteButtonCustom, style: .plain, target: self, action: #selector(tapDelete))
        deleteButton.tintColor = colorDeafault
        navigationItem.rightBarButtonItem = deleteButton
        navigationController?.navigationBar.prefersLargeTitles = true
        
        return tableView
    }

    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
    private func button() -> UIButton {
        let button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .medium))
       
        button.setImage(image, for: .normal)
        button.tintColor = colorDeafault
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -25),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        return button
    }
    
    
    @objc func tapDelete() {
        tableView.isEditing = !tableView.isEditing
        
        if tableView.isEditing {
            let customIcon = UIImage(systemName: "minus.circle.fill")
            let editIcon = UIBarButtonItem(image: customIcon, style: .plain, target: self, action: #selector(tapDelete))
            editIcon.tintColor = colorDeafault
            navigationItem.rightBarButtonItem = editIcon
        } else {
            let customIcon = UIImage(systemName: "minus.circle")
            let editIcon = UIBarButtonItem(image: customIcon, style: .plain, target: self, action: #selector(tapDelete))
            editIcon.tintColor = colorDeafault
            navigationItem.rightBarButtonItem = editIcon
        }
        
    }
    
    @objc func tapButton() {
        let plusVC = PlusVC()
        plusVC.delegate = self
        present(plusVC, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension FocusVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxView", for: indexPath) as? CheckBoxView else { return UITableViewCell() }
        
        let text = notes[indexPath.row]
        let subtitle = notesSubtitle[indexPath.row]
        
        cell.checkBox.titleText(text: text)
        cell.checkBox.subtitleText(text: subtitle)
        
        
        return cell
    }
    
   
}

//MARK: - UITableViewDelegate
extension FocusVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
   
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            self.notes.remove(at: indexPath.row)
            self.notesSubtitle.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
           
            completionHandler(true)
        }
        
        
        deleteAction.backgroundColor = .systemGray
    
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}


extension FocusVC: PlusVCDelegate {
    func send(text: String, textSubtitle: String) {
        self.notes.append(text)
        self.notesSubtitle.append(textSubtitle)
        
        self.tableView.reloadData()
    }
}


