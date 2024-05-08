//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Vishal Kamble on 06/05/24.
//

import UIKit

class NotesViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleFiled: UITextView!
    @IBOutlet weak var priorityPicker: UIPickerView!
    let priorities: [Priority] = [.high, .medium, .low]
        var selectedPriority: Priority = .low
    var existingNote: Note?

    let noteManager = NoteManager()
        override func viewDidLoad() {
            super.viewDidLoad()
            priorityPicker.delegate = self
            priorityPicker.dataSource = self
            titleTextField.text = existingNote?.title
            subtitleFiled.text = existingNote?.subtitle
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        // MARK: - UIPickerViewDelegate & UIPickerViewDataSource
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return priorities.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return priorities[row].rawValue
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedPriority = priorities[row]
        }
        
        // MARK: - Actions
        
    
    @IBAction func clearTextBtn(_ sender: UIButton) {
        titleTextField.text = ""
        subtitleFiled.text = ""
        priorityPicker.selectRow(0, inComponent: 0, animated: true)
        selectedPriority = .low
        
    }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty else {
               showAlert(message: "Please enter a title.")
               return
           }
           
           guard let subtitle = subtitleFiled.text, !subtitle.isEmpty else {
               showAlert(message: "Please enter a subtitle.")
               return
           }
           
           // Convert Date to String
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           let dateString = dateFormatter.string(from: Date())
           
           if var existingNote = existingNote {
               existingNote.title = title
               existingNote.subtitle = subtitle
               existingNote.date = dateString
               existingNote.priority = Priority(rawValue: selectedPriority.rawValue) ?? .low
               
               noteManager.saveOrUpdate(note: existingNote)
           } else {
               let note = Note(id: UUID(), title: title, subtitle: subtitle, date: dateString, priority: selectedPriority)
            
               noteManager.saveOrUpdate(note: note)
           }
           
           // Show success message
           showAlert(message: "Note saved successfully.")
       }
           // Existing code
           
           func showAlert(message: String) {
               let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
}

