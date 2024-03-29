//
//  EntryViewController.swift
//  NotesApp
//
//  Created by Vishal Kamble on 29/03/24.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet var titlefield: UITextField!
    @IBOutlet var notefield: UITextView!
    
    public var complition: ((String, String) ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlefield.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:  "Save", style:.done, target:  self, action: #selector(didTapSave))
        // Do any additional setup after loading the view.
    }
    @objc func didTapSave () {
        if let text = titlefield.text, !text.isEmpty, !notefield.text.isEmpty{
      complition?(text, notefield.text)
        }
        
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
