//
//  HomeViewModel.swift
//  NotesApp
//
//  Created by ShreeThaanu on 10/09/22.
//

import Foundation
import UIKit

class HomeViewModel {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchFromApi(){
        let url = URL(string: GlobalConstant.notesApi)!
        Webservice().getNotes(url: url) { articles in
            if let articles = articles {
              //  self.articleListVM = ArticleListViewModel(articles: articles)
            }
        }
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
