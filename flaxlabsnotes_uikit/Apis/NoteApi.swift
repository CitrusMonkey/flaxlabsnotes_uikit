//
//  NoteApi.swift
//  flaxlabsnotes_uikit
//
//  Created by Lucas French on 10/19/23.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON

class NoteApi {
    
    let database = Database.database()
    
    func observeNotes(completion: @escaping ([Note]) -> Void) {
        let notesRef = database.reference().child("notes")
        notesRef.observe(.value) { snapshot, error  in
            if error != nil {
                print("error", error)
                return
            }
            var notesArray: [Note] = []
            let snapshotJSON = JSON(snapshot.value)
            for (indexString, notecontent): (String, JSON) in snapshotJSON {
                let newNote = Note.transformNote(dict: notecontent)
                notesArray.append(newNote)
            }
            completion(notesArray)
        }
    }
    
    func updateNotes(notes: [Note]) {
        let notesRef = database.reference().child("notes")
        var newDict: [String: Any] = [:]
        for (n, note) in notes.enumerated() {
            let newNoteConvert = [
                "title": note.title,
                "content": note.content
            ]
            newDict["\(n)"] = newNoteConvert
        }
        notesRef.setValue(newDict)
    }
    
    
}
