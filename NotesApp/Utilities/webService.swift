//
//  webService.swift
//  NotesApp
//
//  Created by ShreeThaanu on 09/09/22.
//

import Foundation

class Webservice {

    func getNotes(url: URL, completion: @escaping ([NotesData]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error data nilll", error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let notesList = try? JSONDecoder().decode([NotesData].self, from: data)
                if let notesList = notesList {
                    completion(notesList)
                }
            }
        }.resume()
    }
}

