//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Vishal Kamble on 29/03/24.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet var titleLable:UILabel!
    @IBOutlet var noteLable: UITextView!
    
    public var noteTitle: String = ""
    public var note: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLable.text = noteTitle
        noteLable.text = note

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
