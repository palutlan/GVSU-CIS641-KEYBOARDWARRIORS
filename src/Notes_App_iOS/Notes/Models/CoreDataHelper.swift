//
//  CoreDataManager.swift
//  MyNotes
//
//  Created by Sai Palutla on 12/2/22.
//

import Foundation
import CoreData

class CoreDataHelper {
    static let manager = CoreDataHelper(modelName: "Notes")
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { desc, err in
            guard err == nil else {
                fatalError(err!.localizedDescription)
            }
            completion?()
        }
    }
    
    
    func save(){
        if viewContext.hasChanges{
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}


extension CoreDataHelper {
    func createNote() -> Note{
        let note = Note(context: CoreDataHelper.manager.viewContext)
        note.id = UUID()
        note.text = ""
        note.lastUpdated = Date()
        save()
        return note
    }
    
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
    
    func fetchNotesFromStorage(filter: String? = nil) -> [Note] {
        let fetchrequest: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDesc = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        fetchrequest.sortDescriptors = [sortDesc]
        
        if filter != nil {
            let pred = NSPredicate(format: "text contains[cd] %@", filter!)
            fetchrequest.predicate = pred
        }
        return (try? viewContext.fetch(fetchrequest)) ?? []
    }
    
    
}
