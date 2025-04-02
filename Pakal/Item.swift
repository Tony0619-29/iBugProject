//
//  Item.swift
//  Pakal
//
//  Created by Antonio Medina on 02/04/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
