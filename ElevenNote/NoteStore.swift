//
//  NoteStore.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import UIKit

class NoteStore {
    // MARK: Singleton Pattern
    class var sharedNoteStore : NoteStore {
    struct Static {
        static let instance : NoteStore = NoteStore()
        }
        return Static.instance
    }
    
    // Private init to force usage of singleton
    private init() {
        load()
    }
    
    // MARK: Properties
    
    // Collection of all notes. Exposing the raw array for simplicity
    var allNotes : [Note]!
    
    
    // MARK: Methods
    
    // Fetch a specific note
    func getNote(index:Int) -> Note {
        return allNotes[index]
    }
    
    // count
    func noteCount() -> Int
    {
        return allNotes.count
    }
    
    // create a note
    func createNote() -> Note {
        var note = Note()
        allNotes.append(note)
        return note
    }
    
    // deleting a note
    func deleteNote(noteToDelete:Note) {
        
        // Look at each note
        for (i, note) in enumerate(allNotes) {
            // And find a matching instance to remove
            if note === noteToDelete {
                allNotes.removeAtIndex(i)
                return
            }
        }
        
    }
    
    // MARK: Persistence
    
    // 1: Find the file & directory we want to save to
    func archiveFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as NSString
        let path = documentsDirectory.stringByAppendingPathComponent("NoteStore.plist")
        
        return path
    }
    
    // 2: Do the save to disk
    func save() {
        NSKeyedArchiver.archiveRootObject(allNotes, toFile: archiveFilePath())
    }
    
    // 3: Do the reload from disk
    func load() {
        let filePath = archiveFilePath()
        let fileManager = NSFileManager.defaultManager()
        
        if fileManager.fileExistsAtPath(filePath) {
            allNotes = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as [Note]
        } else {
            allNotes = [Note]()
        }
        
        
    }
    
}
