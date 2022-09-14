//
//  CardDetailItem.swift
//  NotesApp
//
//  Created by ShreeThaanu on 11/09/22.
//

import Foundation

class CardDetailItem: Hashable, Decodable {
    let id: String?
    let title: String?
    let body: String?
    let created_time: Int?
    let image: String?
    var storedImage: Data?
    let subitems: [CardDetailItem]

    init(title: String, id: String, body: String, created_time: Int, image: String, storedImage: Data, subitems: [CardDetailItem] = []) {
        self.title = title
        self.id = id
        self.body = body
        self.created_time = created_time
        self.image = image
        self.storedImage = storedImage
        self.subitems = subitems
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: CardDetailItem, rhs: CardDetailItem) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  private let identifier = UUID()
}

