//
//  NoteManager.swift
//  NotesApp
//
//  Created by Vishal Kamble on 06/05/24.
//

import Foundation
import UIKit
import CoreData

class NoteManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "NotesApp")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func saveOrUpdate(note: Note) {
        let context = persistentContainer.viewContext
        
        // Check if a note with the given ID already exists
        if let existingNote = fetchNoteByID(noteID: note.id) {
            // Note already exists, update it
            updateNote(note: existingNote, title: note.title, subtitle: note.subtitle, date: note.date, priority: note.priority.rawValue)
        } else {
            // Note doesn't exist, create a new one
            createNote(notes: note)
        }
    }
    
    func fetchNoteByID(noteID: UUID) -> NotesData? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NotesData> = NotesData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", noteID as CVarArg)
        
        do {
            let notes = try context.fetch(fetchRequest)
            return notes.first
        } catch {
            print("Error fetching note by ID: \(error)")
            return nil
        }
    }
    
    func createNote(notes: Note) {
        let context = persistentContainer.viewContext
        let newNote = NotesData(context: context)
        newNote.id = notes.id
        newNote.title = notes.title
        newNote.subtitle = notes.subtitle
        newNote.date = notes.date
        newNote.priority = notes.priority.rawValue
        
        do {
            try context.save()
            print("Note saved successfully")
        } catch {
            print("Error saving note: \(error)")
        }
    }
    
    func updateNote(note: NotesData, title: String, subtitle: String, date: String, priority: String) {
        let context = persistentContainer.viewContext
        note.title = title
        note.subtitle = subtitle
        note.date = date
        note.priority = priority
        
        do {
            try context.save()
            print("Note updated successfully")
        } catch {
            print("Error updating note: \(error)")
        }
    }
    
    func deleteNote(note: NotesData) {
        let context = persistentContainer.viewContext
        context.delete(note)
        
        do {
            try context.save()
            print("Note deleted successfully")
        } catch {
            print("Error deleting note: \(error)")
        }
    }
    
    func fetchNotes() -> [NotesData] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NotesData> = NotesData.fetchRequest()
        
        do {
            let notes = try context.fetch(fetchRequest)
            return notes
        } catch {
            print("Error fetching notes: \(error)")
            return []
        }
    }
}
