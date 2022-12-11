//
//  ListNoteTableViewCell.swift
//  MyNotes
//
//  Created by Sai Palutla on 30/10/2022.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    static let identifier = "NoteTableViewCell"
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    func setup(note: Note) {
        titleLabel.text = note.title
        descriptionLabel.text = note.desc
    }
}
