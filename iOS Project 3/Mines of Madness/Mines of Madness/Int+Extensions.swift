//
//  Int+Extensions.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/7/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import Foundation

extension Int {
    mutating func clamp(min min:Int, max:Int) {
        if (self < min) {
            self = min;
        } else if (self > max) {
            self = max;
        }
    }
}