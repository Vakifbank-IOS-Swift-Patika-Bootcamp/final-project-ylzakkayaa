//
//  File.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation
import UIKit

protocol NoteDetailViewModelProtocol {
    var delegate: NoteDetailViewModelDelegate? { get set }
    func addOrUpdate(selectedNote: Bool, selectedNoteText: String, currentNoteText: String, gameName: String) -> String
    func noteTextControl(noteText: String, selectedNoteTrueOrFalse: Bool, button: UIButton, gameLabelHidden: UITextField, dateText: UILabel, selectedNote: Notes?) -> Bool
    func currentTime() -> String
}

protocol NoteDetailViewModelDelegate: AnyObject {
    func gamesLoaded()
    func savePressed(currentText: String, gameName: String, noteDate: String)
    func updatePressed(previousText: String, currentText: String)
}

final class NoteDetailViewModel: NoteDetailViewModelProtocol {
    
    var delegate: NoteDetailViewModelDelegate?
    var notes: [Notes]?
    
    func noteTextControl(noteText: String, selectedNoteTrueOrFalse: Bool, button: UIButton, gameLabelHidden: UITextField, dateText: UILabel, selectedNote: Notes?)  -> Bool {
        if noteText != "" {
            var selectedTrue = selectedNoteTrueOrFalse
            selectedTrue = true
            button.setTitle("Update", for: .normal)
            gameLabelHidden.isUserInteractionEnabled = false
            dateText.text = selectedNote?.noteDate
            return selectedTrue
        } else {
            return false
        }
    }
    
    func addOrUpdate(selectedNote: Bool, selectedNoteText: String, currentNoteText: String, gameName: String) -> String {
        if selectedNote == true {
            if selectedNoteText == currentNoteText {
                return "No changes note."
            } else {
                delegate?.updatePressed(previousText: selectedNoteText, currentText: currentNoteText)
            }
        } else {
            if (currentNoteText == "" || gameName == "") {
                return "Not all values ​​are filled."
            } else {
                delegate?.savePressed(currentText: currentNoteText, gameName: gameName, noteDate: currentTime())
            }
        }
        return ""
    }
    
    func currentTime() -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, h:mm:ss a"
        let formatteddate = formatter.string(from: time as Date)
        return formatteddate
    }
}

