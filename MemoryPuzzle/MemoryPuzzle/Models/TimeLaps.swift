//
//  TimeLaps.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/06.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation
import UIKit

struct TimeLaps {
    static let shared = TimeLaps.self
    private init() {}
    var normal: Double = 0
    var nightMare: Double = 0
    var hell: Double = 0
}
