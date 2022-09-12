//
//  HomeViewModel.swift
//  NotesApp
//
//  Created by ShreeThaanu on 10/09/22.
//

import Foundation
import UIKit
import CoreData

class HomeViewModel {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notesData: [NotesData] = []

    func fetchFromApi() {
        let url = URL(string: GlobalConstant.notesApi)!
        Webservice().getNotes(url: url) { [self] notes in
            if let notes = notes {
                self.notesData = notes
                createData()
            }
        }
    }

    func createData(){
        let newitem = Notes(context: context)
        for i in notesData {
            print("items GOING in DB are: ")
            newitem.title = i.title!
        }
        do{
            try context.save()
        }
        catch {
        }
    }
    
    func deleteAllData(entity: String){

//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false

    do {
        let arrUsrObj = try context.fetch(fetchRequest)
        for usrObj in arrUsrObj as! [NSManagedObject] {
            context.delete(usrObj)
        }
       try context.save() //don't forget
        } catch let error as NSError {
        print("delete fail--",error)
      }

    }
    
    func getData(){
        do {
            let items = try context.fetch(Notes.fetchRequest())
            print("items inside DB is: ", items)
        }
        catch {
            
        }
    }
}
