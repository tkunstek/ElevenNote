//
//  NoteDetailViewController.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    // Note we are editing / creating
    var note = Note()
    
    // Completion block to call when user taps save
    var completion : ( (Note) -> () )?
    // Block to call when user taps cancel
    var cancel : (() -> ())?
    
    // Interface builder outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update the screen with the note content
        titleTextField.text = note.title
        noteTextField.text = note.text
        
        self.title = note.title
        
        // Give focus to the note text area
        titleTextField.becomeFirstResponder()
        
    }
    
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        // If we have a completion block set, call it
        if let doSave = completion {
            note.title = titleTextField.text
            note.text = noteTextField.text
            doSave(note)
        }
        
        // Dismiss note detail view
        if self.navigationController != nil {
            self.navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        // If we have a cancel block set, call it
        if let doCancel = cancel {
            doCancel()
        }
        
        // Dismiss note detail view
        if self.navigationController != nil {
            self.navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
}