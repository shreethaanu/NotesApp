//
//  addNotesViewController.swift
//  NotesApp
//
//  Created by ShreeThaanu on 13/09/22.
//

import UIKit

class addNotesViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var addItemsStack: UIStackView!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var titleText: UITextField!
    
    var notesListData: [NotesData] = []
    var viewModel: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //addItemsStack.isHidden = true
    }
    
    @IBAction func addAttachment(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false //If you want edit option set "true"
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        print(tempImage.pngData())
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNotes(_ sender: Any) {
        let notes = NotesData(id: "0", title: titleText.text, body: body.text, created_time: 000, image: "")
        notesListData = [notes]
        viewModel.createData(notesData: notesListData)
    }
}
