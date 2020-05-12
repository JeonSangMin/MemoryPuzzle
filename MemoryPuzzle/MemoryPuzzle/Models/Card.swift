//
//  Card.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/08.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation

struct Card {
    let name: String

}

var card: [String] = {
    var arr = [String]()
    (0...40).forEach {
        arr.append("item\($0)")
    }
    return arr
}()

var normalCards: [Card] = Array(1...10).map { _ in
    Card(name: card.randomElement()!)
}

var nightMareCards: [Card] = Array(1...20).map { _ in
    Card(name: card.randomElement()!)
}

var hellCards: [Card] = Array(1...30).map { _ in
    Card(name: card.randomElement()!)
}
