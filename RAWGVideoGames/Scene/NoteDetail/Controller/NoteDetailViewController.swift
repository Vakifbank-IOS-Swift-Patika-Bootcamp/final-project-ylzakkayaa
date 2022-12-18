//
//  NoteDetailViewController.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import UIKit

protocol NoteDetailViewControllerDelegate: AnyObject {
    func didAddNote(gameNote: Notes)
    func didUpdateNote(previousText: String, currentText: String, noteDate: String)
}

final class NoteDetailViewController: BaseViewController {

    @IBOutlet weak var addGameNameLabel: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addOrUpdateButtonOutlet: UIButton!
    
    private var addNoteViewModel: NoteDetailViewModelProtocol = NoteDetailViewModel()
    weak var delegate: NoteDetailViewControllerDelegate?
    var selectedNote: Notes?
    private var selectedNoteTrueOrFalse = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNoteViewModel.delegate = self
        addOrUpdateButtonOutlet.setTitle("Add".localized(), for: .normal)
        
        dateLabel.text = addNoteViewModel.currentTime()
        
        noteTextView.text = selectedNote?.noteText
        addGameNameLabel.text = selectedNote?.gameName
        
        selectedNoteTrueOrFalse = addNoteViewModel.noteTextControl(noteText: selectedNote?.noteText ?? "", selectedNoteTrueOrFalse: selectedNoteTrueOrFalse, button: addOrUpdateButtonOutlet, gameLabelHidden: addGameNameLabel, dateText: dateLabel, selectedNote: selectedNote)
    }
    
    
    @IBAction func addOrUpdateButton(_ sender: Any) {
        var showAlert = addNoteViewModel.addOrUpdate(selectedNote: selectedNoteTrueOrFalse, selectedNoteText: selectedNote?.noteText ?? "", currentNoteText: noteTextView.text, gameName: addGameNameLabel.text ?? "")
        if showAlert != "" {
            self.showErrorAlert(message: "\(showAlert)")
        } else {
            dismiss(animated: true)
        }
    }
}

extension NoteDetailViewController: NoteDetailViewModelDelegate {
    func savePressed(currentText: String, gameName: String, noteDate: String) {
        let note = CoreDataManager.shared.saveNote(text: currentText, gameName: gameName, noteDate: addNoteViewModel.currentTime())!
        self.delegate?.didAddNote(gameNote: note)
    }
    
    func updatePressed(previousText: String, currentText: String) {
        CoreDataManager.shared.updateNote(previousText: previousText, currentText: currentText, noteDate: addNoteViewModel.currentTime())
        self.delegate?.didUpdateNote(previousText: previousText, currentText: currentText, noteDate: addNoteViewModel.currentTime())
    }
    
    func gamesLoaded() {
    }
}



