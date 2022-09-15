//
//  notesDetailViewController.swift
//  NotesApp
//
//  Created by ShreeThaanu on 13/09/22.
//

import UIKit

class notesDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var addItemsStack: UIStackView!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var coverPhotoHeight: NSLayoutConstraint!
    
    var notesListData: [NotesData] = []
    var imageData: Data?
    var notesDetail: CardDetailItem? = nil
    var viewModel: HomeViewModel = HomeViewModel()
    var isDetailPageController: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constructViews()
    }
    
    fileprivate func populateDetailView() {
        titleText.text = notesDetail?.title
        body.attributedText = returnMarkup()
        titleText.isUserInteractionEnabled = false
        body.isEditable = false
    }
    
    fileprivate func setCoverPhoto() {
        coverPhotoHeight.constant = 160
        if notesDetail?.image != "" {
            coverPhoto.downloaded(from: (notesDetail?.image)!)
        }
        else {
            coverPhoto.image = UIImage(data: (notesDetail?.storedImage)!)
        }
    }
    
    fileprivate func constructImageView(){
        if notesDetail?.image == "" && ((notesDetail?.storedImage?.isEmpty)!) {
            coverPhotoHeight.constant = 0
        }
        else {
            setCoverPhoto()
        }
    }
    
    fileprivate func returnMarkup() -> NSAttributedString {
        guard let attributedString = try? NSAttributedString(markdown: notesDetail?.body ?? "") else {
            return NSAttributedString(string: notesDetail?.body ?? "")
        }
        return attributedString
    }
    
    fileprivate func constructViews(){
        if isDetailPageController {
            addItemsStack.isHidden = true
            populateDetailView()
            constructImageView()
        }
    }
    
    @IBAction func addAttachment(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageData = tempImage.jpegData(compressionQuality: 1.0)
        if imageData != nil {
            coverPhotoHeight.constant = 160
            coverPhoto.image = tempImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNotes(_ sender: Any) {
        let notes = NotesData(id: "0", title: titleText.text, body: body.text, created_time: Int(Date().timeIntervalSince1970), image: "", storedImage: imageData)
        notesListData = [notes]
        viewModel.createData(notesData: notesListData)
        showAlert(withTitle: "Success", withMessage: "Data added successfully")
    }
}
