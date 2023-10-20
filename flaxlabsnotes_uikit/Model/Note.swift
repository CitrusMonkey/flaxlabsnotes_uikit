//
//  Note.swift
//  flaxlabsnotes_uikit
//
//  Created by Lucas French on 10/19/23.
//

import Foundation
import SwiftyJSON

class Note {
    var title: String?
    var content: String?
}

extension Note {
    static func transformNote(dict: JSON) -> Note {
        let note = Note()
        note.title = dict["title"].string
        note.content = dict["content"].string
        return note
    }
}
