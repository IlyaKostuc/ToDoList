//
//  PlusVC.swift
//  ToDDoList
//
//  Created by Maxim Fedoseenko on 17.04.2024.
//

import UIKit

protocol PlusVCDelegate: AnyObject {
    func send(text: String, textSubtitle: String)
}

class PlusVC: UIViewController {

    weak var delegate: PlusVCDelegate? = nil
    
    private var colorDeafault: UIColor {#colorLiteral(red: 0.3801780305, green: 0.4076312424, blue: 0.4427852878, alpha: 1)}
    
    private lazy var labelNote = setupLabel()
    private lazy var textFieldd = setupTextField()
    private lazy var button = setupButton()
    
    private lazy var labelNoteSubtitle = setupLabelSubtitle()
    private lazy var textFielddSubtitle = setupTextFieldSubtitle()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(labelNote)
        view.addSubview(textFieldd)
        view.addSubview(button)
        
        view.addSubview(labelNoteSubtitle)
        view.addSubview(textFielddSubtitle)
        
        setupLabelConstrains()
        setupTextFieldConstrains()
        setupButtonConstrains()
        
        setupTextFieldSubtitleConstrains()
        setupLabelSubtitleConstrains()
        
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        
    
    }
    
//    @objc private func keyboardWillShow(notification: NSNotification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//            let bottomSpace = self.view.frame.height - (button.frame.origin.y + button.frame.height)
//            self.view.frame.origin.y -= keyboardHeight - bottomSpace + 10
//        }
//    }
//    
//    @objc private func keyboardWillHide() {
//        self.view.frame.origin.y = 0
//    }
}

extension PlusVC {
    //MARK: - Title
    private func setupLabel() -> UILabel {
        let label = UILabel()
        label.text = "Note"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }
    
    private func setupTextField() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "What's youre note?"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        
        textField.delegate = self
        
        //textField.becomeFirstResponder() //фукус становится автоматически
        
        return textField
    }
    
    private func setupButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = colorDeafault
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(saveNote) , for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
        
        return button
    }
    
    //MARK: - Subtitle
    private func setupLabelSubtitle() -> UILabel {
        let label = UILabel()
        label.text = "Focus"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }
    
    private func setupTextFieldSubtitle() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "What's youre focus?"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        
        textField.delegate = self
        
        //textField.becomeFirstResponder() //фукус становится автоматически
        
        return textField
    }
    
    //MARK: - Constrains
   
    private func setupLabelConstrains() {
        labelNote.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelNote.topAnchor.constraint(equalTo: view.topAnchor,constant: 450),
            labelNote.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            labelNote.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
        ])
    }
    
    private func setupTextFieldConstrains() {
        textFieldd.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldd.topAnchor.constraint(equalTo: labelNote.topAnchor, constant: 30),
            textFieldd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupButtonConstrains() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textFielddSubtitle.topAnchor, constant: 80),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
          
            button.heightAnchor.constraint(equalToConstant: 50)
           
        ])
    }
    
    
    private func setupLabelSubtitleConstrains() {
        labelNoteSubtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelNoteSubtitle.topAnchor.constraint(equalTo: textFieldd.bottomAnchor,constant: 30),
            labelNoteSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            labelNoteSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            //labelNoteSubtitle.bottomAnchor.constraint(equalTo: textFieldd.topAnchor)
        ])
    }
    
    private func setupTextFieldSubtitleConstrains() {
        textFielddSubtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFielddSubtitle.topAnchor.constraint(equalTo: labelNoteSubtitle.topAnchor, constant: 30),
            textFielddSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFielddSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    

    @objc func saveNote() {
        guard let text = textFieldd.text, let textSubtitle = textFielddSubtitle.text else { return }
        self.delegate?.send(text: text, textSubtitle: textSubtitle)
        print("Tap")
        dismiss(animated: true)
    }
}

extension PlusVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
//
//#Preview {
//    PlusVC()
//}
