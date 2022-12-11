//
//  ListNotesViewController.swift
//  MyNotes
//
//  Created by Sai Palutla on 25/10/2022.
//

import UIKit

protocol ListNotesDelegate: AnyObject {
    func refreshNotes()
    func deleteNote(with id: UUID)
}

class ListViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var notesCountLbl: UILabel!
    private let searchController = UISearchController()
    
    private var notes: [Note] = [] {
        didSet {
            notesCountLbl.text = "\(notes.count) \(notes.count == 1 ? "Note" : "Notes")"
            searchedNotes = notes
        }
    }
    private var searchedNotes: [Note] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        tableView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        configureSearchBar()
        fetchNotesFromStorage()
    }
    
    private func indexForNote(id: UUID, in list: [Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0.id == id }) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    @IBAction func createNewNoteClicked(_ sender: UIButton) {
        goToEditNote(createNote())
    }
    
    private func goToEditNote(_ note: Note) {
        let controller = storyboard?.instantiateViewController(identifier: EditViewController.identifier) as! EditViewController
        controller.note = note
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    private func createNote() -> Note {
        let note = CoreDataHelper.manager.createNote()
        notes.insert(note, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        
        return note
    }
    
    private func fetchNotesFromStorage() {
        notes = CoreDataHelper.manager.fetchNotesFromStorage()
    }
    
    private func deleteNoteFromStorage(_ note: Note) {
       
        
        deleteNote(with: note.id!)
        CoreDataHelper.manager.deleteNote(note)
    }
    
    private func searchNotesFromStorage(_ text: String) {
        notes = CoreDataHelper.manager.fetchNotesFromStorage(filter: text)
        tableView.reloadData()
    }
}


extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier) as! NoteTableViewCell
        cell.setup(note: searchedNotes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToEditNote(searchedNotes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNoteFromStorage(searchedNotes[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}


extension ListViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search("")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        searchNotesFromStorage(query)
    }
    
    func search(_ query: String) {
        if query.count >= 1 {
            searchedNotes = notes.filter { $0.text!.lowercased().contains(query.lowercased()) }
        } else{
            searchedNotes = notes
        }
        
        tableView.reloadData()
    }
}


extension ListViewController: ListNotesDelegate {
    
    func refreshNotes() {
        notes = notes.sorted { $0.lastUpdated! > $1.lastUpdated! }
        tableView.reloadData()
    }
    
    func deleteNote(with id: UUID) {
        let indexPath = indexForNote(id: id, in: searchedNotes)
        searchedNotes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // just so that it doesn't come back when we search from the array
        notes.remove(at: indexForNote(id: id, in: notes).row)
    }
}
