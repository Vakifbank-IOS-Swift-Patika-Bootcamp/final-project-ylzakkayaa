//
//  NoteListViewController.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import UIKit

final class NoteListViewController: UIViewController {

    @IBOutlet weak var addNoteButtonOutlet: UIButton!
    @IBOutlet weak var noteListTableView: UITableView! {
        didSet {
            noteListTableView.delegate = self
            noteListTableView.dataSource = self
            noteListTableView.register(UINib(nibName: "NoteListTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        }
    }
    
    private var noteViewModel: NoteListViewModelProtocol = NoteListViewModel()
    private var selectedNote: Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteViewModel.delegate = self
        noteViewModel.fetchNotes()
        
        //Yeni note eklmeek için float button tanımlarını yaptım.
        addNoteButtonOutlet.setTitle("Add".localized(), for: .normal)
        addNoteButtonOutlet.layer.cornerRadius = 30
        addNoteButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        addNoteButtonOutlet.widthAnchor.constraint(equalToConstant: 60).isActive = true
        addNoteButtonOutlet.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addNoteButtonOutlet.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        addNoteButtonOutlet.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        noteListTableView.reloadData()
    }
    @IBAction func addNoteButton(_ sender: Any) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailViewController else { return }
        detailVC.delegate = self
        present(detailVC, animated: true)
    }
}

extension NoteListViewController: NoteListViewModelDelegate {
    func gamesLoaded() {
        noteListTableView.reloadData()
    }
}

extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noteViewModel.getNotesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteListTableViewCell, let model = noteViewModel.getNotes(at: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(note: model)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150 //Cell height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = noteViewModel.getNotes(at: indexPath.row)
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailViewController else { return }
        detailVC.selectedNote = selectedNote
        detailVC.delegate = self
        self.present(detailVC, animated: true)
        selectedNote = nil
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        noteViewModel.deleteNote(indexPath: indexPath, editingStyle: .delete)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}


extension NoteListViewController: NoteDetailViewControllerDelegate {
    func didAddNote(gameNote: Notes) {
        noteViewModel.addNotes(note: gameNote)
        noteListTableView.reloadData()
    }
    
    func didUpdateNote(previousText: String, currentText: String, noteDate: String) {
        noteListTableView.reloadData()
    }
}



