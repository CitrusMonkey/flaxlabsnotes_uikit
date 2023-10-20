//
//  NoteEditTableViewCell.swift
//  flaxlabsnotes_uikit
//
//  Created by Lucas French on 10/19/23.
//


import UIKit

class NoteEditTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    let titleTextView: UITextView = {
        let titleTextView = UITextView()
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        return titleTextView
    }()
    let contentTextView: UITextView = {
        let contentTextView = UITextView()
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        return contentTextView
    }()
    let confirmButton: UIButton = {
        let confirmButton = UIButton()
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        return confirmButton
    }()
    let deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()
    
    func setupSubviews() {
        setupTitleTextView()
        setupContentTextView()
        setupConfirmButton()
        setupDeleteButton()
    }
    
    let xOffset: CGFloat = 15.0
    func setupTitleTextView() {
        titleTextView.textColor = .black
        titleTextView.font = UIFont(name: "Avenir-Heavy", size: 17.5)
        titleTextView.textAlignment = .left
        titleTextView.textContainer.maximumNumberOfLines = 1
        contentView.addSubview(titleTextView)
        titleTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: xOffset).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -xOffset).isActive = true
        titleTextView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    func setupContentTextView() {
        contentTextView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        contentTextView.layer.cornerRadius = 5.0
        contentTextView.textColor = .black
        contentTextView.font = UIFont(name: "Avenir-Medium", size: 15.0)
        contentTextView.textAlignment = .left
        contentTextView.isScrollEnabled = false
        contentView.addSubview(contentTextView)
        contentTextView.leftAnchor.constraint(equalTo: titleTextView.leftAnchor).isActive = true
        contentTextView.rightAnchor.constraint(equalTo: titleTextView.rightAnchor).isActive = true
        contentTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor).isActive = true
        contentTextView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    }
    func setupConfirmButton() {
        confirmButton.backgroundColor = UIColor.systemGreen
        confirmButton.layer.cornerRadius = 5.0
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
        contentView.addSubview(confirmButton)
        confirmButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: xOffset).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -xOffset).isActive = true
        confirmButton.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 10.0).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    func setupDeleteButton() {
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        contentView.addSubview(deleteButton)
        deleteButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: xOffset).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -xOffset).isActive = true
        deleteButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 5.0).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
    }
    
    weak var noteListVC: NoteListViewController?
    var note: Note? {
        didSet {
            titleTextView.text = note?.title
            contentTextView.text = note?.content
        }
    }
    
    @objc func handleConfirm() {
        guard let indexRow = noteListVC?.tableView.indexPath(for: self)?.row else { return }
        guard
            titleTextView.text != nil,
            titleTextView.text != "",
            contentTextView.text != nil,
            contentTextView.text != ""
        else {
            return
        }
        
        let newNote = Note()
        newNote.title = titleTextView.text
        newNote.content = contentTextView.text
        noteListVC?.confirmNewNote(indexRow: indexRow, note: newNote)
    }
    
    @objc func handleDelete() {
        guard let indexRow = noteListVC?.tableView.indexPath(for: self)?.row else { return }
        noteListVC?.deleteNote(indexRow: indexRow)
    }
    
}

