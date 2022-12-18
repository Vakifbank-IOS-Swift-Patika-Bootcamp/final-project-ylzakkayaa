//
//  NoteListTableViewCell.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {

    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    func configureCell(note: Notes) {
        gameNameLabel.text = note.gameName
        noteLabel.text = note.noteText
        noteDate.text = note.noteDate
    }
}
