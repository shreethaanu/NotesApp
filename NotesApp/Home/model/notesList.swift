//
//  notesList.swift
//  NotesApp
//
//  Created by ShreeThaanu on 09/09/22.
//

import Foundation


struct NotesData: Decodable {
    let id: String?
    let title: String?
    let body: String?
    let created_time: Int?
    let image: String?
}

/**
 
 [
   {
     "id": "NID1",
     "archived": false,
     "title": "How to grow your online presence",
     "body": "Source: [Link](https://www.lipsum.com/) It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using **Lorem Ipsum** is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
     "created_time": 1662435338,
     "image": "https://cdn.dribbble.com/userupload/3490202/file/original-1b4619bf6bcd2b67ba5fbf056cd64d03.jpg"
   },
   
 */
