//
//  NoteTableViewCell.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import UIKit

class NoteTableViewCell : UITableViewCell {
    // Interface builder outlets
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var noteTextLabel : UILabel!
    
    // Insert note contents into the cell
    func setupCell(theNote:Note) {
        titleLabel.text = theNote.title
        noteTextLabel.text = theNote.text
        dateLabel.text = theNote.shortDate
    }
    
}
