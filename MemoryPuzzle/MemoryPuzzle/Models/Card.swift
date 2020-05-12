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
    (1...40).forEach {
        arr.append("item\($0)")
    }
    return arr
}()

var normalCards: [Card] = {
    let allCards = card
    let pick10Cards = allCards[randomPick: 10].map {
        Card(name: $0)
    }
    return pick10Cards
}()

var nightMareCards: [Card] = {
    let allCards = card
    let pick20Cards = allCards[randomPick: 20].map {
        Card(name: $0)
    }
    return pick20Cards
}()

var hellCards: [Card] = {
    let allCards = card
    let pick30Cards = allCards[randomPick: 30].map {
        Card(name: $0)
    }
    return pick30Cards
}()


extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}
