//
//  CGPoint+Extensions.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/4/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

extension CGPoint {
    var angle:CGFloat {
        get {
            return atan2(self.y, self.x);
        }
    }
    
    func distance(pt:CGPoint)->CGFloat {
        let dif = self - pt;
        let dist = sqrt(dif.x * dif.x + dif.y * dif.y);
        return dist;
    }
    
    static func pointFromAngle(deg:CGFloat)->CGPoint {
        let ang = deg.degToRad;
        return CGPointMake(cos(ang), sin(ang));
    }
}

func +(left:CGPoint, right:CGPoint)->CGPoint {
    return CGPointMake(left.x + right.x, left.y + right.y);
}

func +=(inout left:CGPoint, right:CGPoint) {
    left = left + right;
}

func -(left:CGPoint, right:CGPoint)->CGPoint {
    return CGPointMake(left.x - right.x, left.y - right.y);
}

func -=(inout left:CGPoint, right:CGPoint) {
    left = left - right;
}

func *(left:CGPoint, right: Int) -> CGPoint {
    return CGPointMake(left.x * CGFloat(right), left.y * CGFloat(right));
}

func *=(inout left:CGPoint, right: Int) {
    left = left * right;
}

func *(left:Int, right: CGPoint) -> CGPoint {
    return CGPointMake(CGFloat(left) * right.x, CGFloat(left) * right.y);
}

func /(left:CGPoint, right: Int) -> CGPoint {
    return CGPointMake(left.x / CGFloat(right), left.y / CGFloat(right));
}

func /=(inout left:CGPoint, right: Int) {
    left = left / right;
}

func *(left:CGPoint, right: CGFloat) -> CGPoint {
    return CGPointMake(left.x * right, left.y * right);
}

func *=(inout left:CGPoint, right: CGFloat) {
    left = left * right;
}

func *(left:CGFloat, right: CGPoint) -> CGPoint {
    return CGPointMake(left * right.x, left * right.y);
}

func /(left:CGPoint, right: CGFloat) -> CGPoint {
    return CGPointMake(left.x / right, left.y / right);
}

func /=(inout left:CGPoint, right: CGFloat) {
    left = left / right;
}



