//
//  NoteListViewModel.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation
import UIKit

protocol NoteListViewModelProtocol {
    var delegate: NoteListViewModelDelegate? { get set }
    func fetchNotes()
    func getNotesCount() -> Int
    func getNotes(at index: Int) -> Notes?
    func getNoteId(at index: Int) -> String?
    func updateNotes(previousText: String, currentText: String, noteDate: String)
    func addNotes(note: Notes)
    func deleteNote(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle)
    func currentTime() -> String
}

protocol NoteListViewModelDelegate: AnyObject {
    func gamesLoaded()
}

final class NoteListViewModel: NoteListViewModelProtocol {
    
    var delegate: NoteListViewModelDelegate?
    var notes: [Notes]?
    
    func fetchNotes() {
        notes = CoreDataManager.shared.getNotes()
        self.delegate?.gamesLoaded()
    }
    
    func updateNotes(previousText: String, currentText: String, noteDate: String) {
        CoreDataManager.shared.updateNote(previousText: previousText, currentText: currentText, noteDate: currentTime())
    }
    
    func addNotes(note: Notes) {
        notes?.append(note)
    }
    
    func getNotesCount() -> Int {
        notes?.count ?? 0
    }
    
    func getNotes(at index: Int) -> Notes? {
        notes?[index]
    }
    
    func getNoteId(at index: Int) -> String? {
        notes?[index].gameName
    }
    
    func deleteNote(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle) {
        let note = notes![indexPath.row]
        CoreDataManager.shared.deleteNote(note: note)
        notes?.remove(at: indexPath.row)
    }
    
    func currentTime() -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, h:mm:ss a"
        let formatteddate = formatter.string(from: time as Date)
        return formatteddate
    }
}









