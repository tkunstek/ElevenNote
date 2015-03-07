//
//  NotesTableViewController.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Leverage the built in TableViewController Edit button
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // ensure we are not in edit mode
        editing = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Here we pass the note they tapped on between the view controllers
        if segue.identifier == "NoteDetailPush" {
            // Get the controller we are going to
            var noteDetail = segue.destinationViewController as NoteDetailViewController
            // Lookup the data we want to pass
            var theCell = sender as NoteDetailTableViewCell
            // Pass the data forward
            noteDetail.theNote = theCell.theNote
        }
    }
    
    
    @IBAction func saveFromNoteDetail(segue:UIStoryboardSegue) {
        // We come here from an exit segue when they hit save on the detail screen
        
        // Get the controller we are coming from
        var noteDetail = segue.sourceViewController as NoteDetailViewController
        
        // If there is a row selected....
        if let indexPath = tableView.indexPathForSelectedRow() {
            // Update note in our store
            NoteStore.sharedNoteStore.updateNote(theNote: noteDetail.theNote)
            
            // The user was in edit mode
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        } else {
            // Otherwise, add a new record
            NoteStore.sharedNoteStore.createNote(theNote: noteDetail.theNote)
            
            // Get an index to insert the row at
            var indexPath = NSIndexPath(forRow: NoteStore.sharedNoteStore.count()-1, inSection: 0)
            
            // Update tableview
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Just return the note count
        return NoteStore.sharedNoteStore.count()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Fetch a reusable cell
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteDetailTableViewCell", forIndexPath: indexPath) as NoteDetailTableViewCell
        
        // Fetch the note
        var rowNumber = indexPath.row
        var theNote = NoteStore.sharedNoteStore.getNote(rowNumber)
        
        // Configure the cell
        cell.setupCell(theNote)
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            NoteStore.sharedNoteStore.deleteNote(indexPath.row)
            // Delete the note from the tableview
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
}
