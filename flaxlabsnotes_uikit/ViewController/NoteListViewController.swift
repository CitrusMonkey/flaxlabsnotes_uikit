//
//  ViewController.swift
//  flaxlabsnotes_uikit
//
//  Created by Lucas French on 10/19/23.
//

import UIKit

class NoteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func setupSubviews() {
        self.navigationItem.title = "FLAX LAB NOTES"
        view.backgroundColor = UIColor.white
        setupTableView()
        setupAddButton()
    }
    
    func setupTableView() {
        tableView.register(NoteTitleTableViewCell.self, forCellReuseIdentifier: "NoteTitleCell")
        tableView.register(NoteEditTableViewCell.self, forCellReuseIdentifier: "NoteEditCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
        self.view.addSubview(tableView)
        // setup constraints
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.reloadData()
    }
    
    func setupAddButton() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(handleAddNote))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        setupSubviews()
        
        Api.Note.observeNotes { newNotes in
            var newNotePackages: [(Note, Bool)] = []
            for note in newNotes {
                newNotePackages.append((note, false))
            }
            self.sampleNotes = newNotePackages
            self.tableView.reloadData()
        }
    }
    
    var sampleNotes: [(Note, Bool)] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let notePackage = sampleNotes[row]
        let note = notePackage.0
        let isFullScreen = notePackage.1
        if isFullScreen == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoteEditCell", for: indexPath) as! NoteEditTableViewCell
            cell.selectionStyle = .default
            cell.noteListVC = self
            cell.note = note
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTitleCell", for: indexPath) as! NoteTitleTableViewCell
            cell.selectionStyle = .default
            cell.note = note
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toggleNoteState(indexPath: indexPath)
    }
    
    func toggleNoteState(indexPath: IndexPath) {
        let row = indexPath.row
        sampleNotes[row].1 = !sampleNotes[row].1
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.insertRows(at: [indexPath], with: .left)
        tableView.endUpdates()
    }
    
    func confirmNewNote(indexRow: Int, note: Note) {
        sampleNotes[indexRow] = (note, true)
        let indexPath = IndexPath(row: indexRow, section: 0)
        toggleNoteState(indexPath: indexPath)
        tableView.reloadData()
        // update firebase
        var newNotes: [Note] = []
        for notePackage in sampleNotes {
            newNotes.append(notePackage.0)
        }
        Api.Note.updateNotes(notes: newNotes)
    }
    
    @objc func handleAddNote() {
        let newNote = Note()
        newNote.title = "New Title"
        newNote.content = "New Content"
        sampleNotes.append((newNote, true))
        tableView.reloadData()
    }
    
    func deleteNote(indexRow: Int) {
        sampleNotes.remove(at: indexRow)
        tableView.reloadData()
        // update firebase
        var newNotes: [Note] = []
        for notePackage in sampleNotes {
            newNotes.append(notePackage.0)
        }
        Api.Note.updateNotes(notes: newNotes)
    }
    
}

