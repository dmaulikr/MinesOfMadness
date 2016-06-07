//
//  CGFloat+Extensions.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/4/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

extension CGFloat {
    static let pi_float = CGFloat(M_PI);
    var radToDeg:CGFloat {
        get {
            return self * CGFloat(180) / CGFloat.pi_float;
        }
    }
    
    var degToRad:CGFloat {
        get {
            return self * CGFloat.pi_float / CGFloat(180);
        }
    }
    
    func between(min:CGFloat, max:CGFloat) -> Bool {
        return self >= min && self <= max;
    }
}
