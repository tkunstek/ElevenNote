//
//  NoteDetailViewController.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    var theNote = Note()
    
    @IBOutlet weak var noteTitleLabel: UITextField!
    
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The view starts here. By now we either have a note to edit
        // or we have a blank note in theNote property we can use
        
        // Update the screen with the contents of theNote
        self.noteTitleLabel.text = theNote.title
        self.noteTextView.text = theNote.text
        
        // Set the Cursor in the note text area
        self.noteTextView.becomeFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Whenever we leave the screen, update our note model
        theNote.title = self.noteTitleLabel.text
        theNote.text = self.noteTextView.text
    }
    
}
