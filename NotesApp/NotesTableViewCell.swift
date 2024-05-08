//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Vishal Kamble on 06/05/24.
//
import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var prioritylbl: UILabel!
    
    var editButtonAction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        configureUI()
    }

    
   

        @IBAction func editButtonTapped(_ sender: UIButton) {
            editButtonAction?()
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        configureUI()
    }
    
    func configCell(note: Note) {
            title.text = note.title
            subtitlelbl.text = note.subtitle
            datelbl.text = note.date
            prioritylbl.text = note.priority.rawValue
        }
    
    private func configureUI() {
        // Set corner radius of the cell
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        // Optionally, add a shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
        layer.masksToBounds = false // Ensure that shadow is visible
    }
}
