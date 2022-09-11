//
//  CardDetailItem.swift
//  NotesApp
//
//  Created by ShreeThaanu on 11/09/22.
//

import Foundation

class CardDetailItem: Hashable {
  let title: String
//  let thumbnailURL: URL
  let subitems: [CardDetailItem]

  init(title: String, subitems: [CardDetailItem] = []) {
    self.title = title
//  self.thumbnailURL = thumbnailURL
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

