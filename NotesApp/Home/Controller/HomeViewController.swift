//
//  HomeViewController.swift
//  NotesApp
//
//  Created by ShreeThaanu on 09/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        getData()
        
    }
    
    func createData(){
        let newitem = Notes(context: context)
        newitem.title = "test notes statically"
        do{
            try context.save()
        }
        catch {
            
        }
        
    }
    
    func deleteData(notesData: Notes){
        context.delete(notesData)
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    func getData(){
        do {
            let items = try context.fetch(Notes.fetchRequest())
            print(items)
        }
        catch {
            
        }
    }
}
