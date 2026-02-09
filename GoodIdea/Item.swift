//
//  Item.swift
//  GoodIdea
//
//  Created by 채유성 on 2/9/26.
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
