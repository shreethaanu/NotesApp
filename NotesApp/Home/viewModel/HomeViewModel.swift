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

    func fetchFromApi(completion: @escaping ([NotesData]?) -> ()) {
        let url = URL(string: GlobalConstant.notesApi)!
        Webservice().getNotes(url: url) { [self] notes in
            if let notes = notes {
                self.notesData = notes
                createData(notesData: notesData)
                completion(notes)
            }
        }
    }

    func createData(notesData: [NotesData]) {
        for i in notesData {
        let newitem = Notes(context: context)
            newitem.title = i.title
            newitem.body = i.body
            newitem.image = i.image ?? ""
            newitem.id = i.id
            newitem.created_time = Date(timeIntervalSince1970: Double(i.created_time ?? 00))
            newitem.storedImage = i.storedImage
        do{
            try context.save()
        }
        catch {
        }
        }
    }

    func deleteAllData(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let arrUsrObj = try context.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                context.delete(usrObj)
            }
            try context.save()
        } catch let error as NSError {
            print("delete fail--",error)
        }
    }

    func fetchDataFromDb() -> [CardDetailItem] {
        var cardDetailItems: [CardDetailItem] = []
        do {
            let items = try context.fetch(Notes.fetchRequest())
            for i in items {
                print("items inside DB is: ", i)
                let cardData = CardDetailItem(title: i.title ?? "", id: i.id ?? "", body: i.body ?? "", created_time: i.created_time , image: i.image ?? "", storedImage: i.storedImage ?? Data())
                cardDetailItems.append(cardData)
            }
        }
        catch {
        }
        return cardDetailItems
    }

    func getNotesData() -> [CardDetailItem] {
        let items = fetchDataFromDb()
        let dates = items.compactMap { $0.created_time }
        let sortedDates = items.sorted{ $0.created_time! > $1.created_time!  }
        return sortedDates
    }
}
