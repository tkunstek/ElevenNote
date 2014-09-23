//
//  ViewController.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController {
    
    // Interface builder outlets
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    // Track which row the user is editing
    var editRow : NSIndexPath?
    // Shorthand access to the note store
    var noteStore = NoteStore.sharedNoteStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
    }
    
    
    @IBAction func editTable(sender: UIBarButtonItem) {
        // Invert our editing state on touch
        self.tableView.editing = !self.tableView.editing
        
        // Update the label on the toolbar button
        if self.tableView.editing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return number of notes
        return noteStore.allNotes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Fetch a cell if there is one available....
        var cell = tableView.dequeueReusableCellWithIdentifier("NoteTableViewCell") as NoteTableViewCell!
        
        if cell == nil {
            // ...Otherwise create one
            cell = NoteTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "NoteTableViewCell")
        }
        
        // Find the specific note we want to show
        var row = indexPath.row
        var note = noteStore.allNotes[row]
        
        // Format the cell for the note
        cell.setupCell(note)
        
        // return the cell
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        // If the user taps on a cell, they are editing the cell
        // Track that cell for editing
        editRow = indexPath
        // then move to the detail screen
        performSegueWithIdentifier("NoteDetailPush", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Stop editing whenever we leave this screen
        tableView.editing = false
        editButton.title = "Edit"
        
        if segue.identifier == "NoteDetailPush" {
            // 1: Grab the new view controller we are about to show
            let noteDetailViewController = segue.destinationViewController as NoteDetailViewController
            
            // 2: If we are in editing mode, pass the note along
            if let row = editRow {
                noteDetailViewController.note = self.noteStore.allNotes[row.row]
            }
            
            // 3: Setup our completion block
            noteDetailViewController.completion = {
                (note) -> () in
                
                // 3a: if coming back from edit mode....
                if let editingRow = self.editRow {
                    // Don't have to do anything with the note, we passed it by reference!
                    
                    // 3a1: Update the table
                    self.tableView.reloadRowsAtIndexPaths([self.editRow!], withRowAnimation: UITableViewRowAnimation.Automatic)
                    
                    // 3a2: Reset state
                    self.editRow = nil
                } else { // 3b: if coming back in edit mode (else)
                    // 3b1: Update our array
                    self.noteStore.allNotes.append(note)
                    
                    // 3b2: Update the table
                    var appendPath = NSIndexPath(forRow: self.noteStore.allNotes.count - 1, inSection: 0)
                    self.tableView.insertRowsAtIndexPaths([appendPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            }
            
            // 4: Setup our cancel block
            noteDetailViewController.cancel = {
                // Reset state
                self.editRow = nil
            }
            
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // If we are deleting a note...
        if editingStyle == .Delete {
            // lookup the note
            var noteToDelete = self.noteStore.allNotes[indexPath.row]
            
            // have store delete it
            noteStore.deleteNote(noteToDelete)
            
            // update the table
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
}

