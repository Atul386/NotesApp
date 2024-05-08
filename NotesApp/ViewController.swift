//
//  ViewController.swift
//  NotesApp
//
//  Created by Vishal Kamble on 06/05/24.
//

import UIKit

struct Note {
    var id:UUID
    var title: String
    var subtitle: String
    var date: String
    var priority: Priority
}


enum Priority: String {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}



class ViewController: UIViewController {

    @IBOutlet weak var notesTableView: UITableView!
    
    let noteManager = NoteManager()
        
        var notes: [NotesData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
        fetchNotes()
        
        let gradientLayer = CAGradientLayer()
           gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: navigationController?.navigationBar.bounds.height ?? 44)
           gradientLayer.colors = [UIColor(red: 99/255, green: 123/255, blue: 227/255, alpha: 1).cgColor,UIColor(red: 106/255, green: 220/255, blue: 218/255, alpha: 1).cgColor]
           gradientLayer.startPoint = CGPoint(x: 0, y: 0)
           gradientLayer.endPoint = CGPoint(x: 1, y: 0)

           // Convert the gradient layer to an image
           UIGraphicsBeginImageContext(gradientLayer.bounds.size)
           gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
           let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.prefersLargeTitles = true

                let appearance = UINavigationBarAppearance()
                appearance.backgroundImage = backgroundImage
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

                navigationController?.navigationBar.tintColor = .white
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.compactAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchNotes()
    }
    
    func fetchNotes() {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let self = self else { return }
                self.notes = self.noteManager.fetchNotes()
                DispatchQueue.main.async {
                    self.notesTableView.reloadData()
                }
            }
        }
    
    @IBAction func addItemBtnClick(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "AddItemSegue", sender: self)
           }
           
           // MARK: - Navigation
           
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "AddItemSegue" {
                   if let destinationVC = segue.destination as? NotesViewController,let note = sender as? Note {
                       destinationVC.existingNote = note
                   }
               }
           }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            // Check if there are no notes available
            if notes.isEmpty {
                // Create a label to display the message
                let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
                messageLabel.text = "No Notes Available"
                messageLabel.textColor = .gray
                messageLabel.textAlignment = .center
                messageLabel.numberOfLines = 0
                messageLabel.sizeToFit()
                
                // Return the label as the header view
                return messageLabel
            } else {
                // Return nil to use the default header view
                return nil
            }
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            // Set the height of the header view
            return notes.isEmpty ? tableView.bounds.size.height : 0.0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as? NotesTableViewCell else {
            return UITableViewCell()
        }
        
        let note = notes[indexPath.row]
               // Convert NotesData to Note
               let noteObject = Note(
                   id: note.id ?? UUID(),
                   title: note.title ?? "",
                   subtitle: note.subtitle ?? "",
                   date: note.date ?? "",
                   priority: Priority(rawValue: note.priority ?? "") ?? .low
               )
        
               cell.configCell(note: noteObject)
        
        cell.editButtonAction = { [weak self] in
                    self?.performSegue(withIdentifier: "AddItemSegue", sender: noteObject)
                }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               let note = notes[indexPath.row]
               noteManager.deleteNote(note: note)
               notes.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
    
}





extension UIView {

func applyGradient(colours: [UIColor], cornerRadius: CGFloat?, startPoint: CGPoint, endPoint: CGPoint)  {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.frame = self.bounds
    if let cornerRadius = cornerRadius {
        gradient.cornerRadius = cornerRadius
    }
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    gradient.colors = colours.map { $0.cgColor }
    self.layer.insertSublayer(gradient, at: 0)
  }
}
