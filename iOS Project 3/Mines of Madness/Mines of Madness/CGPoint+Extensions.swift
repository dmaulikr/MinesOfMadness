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
    
    func distance(_ pt:CGPoint)->CGFloat {
        let dif = self - pt;
        let dist = sqrt(dif.x * dif.x + dif.y * dif.y);
        return dist;
    }
    
    static func pointFromAngle(_ deg:CGFloat)->CGPoint {
        let ang = deg.degToRad;
        return CGPoint(x: cos(ang), y: sin(ang));
    }
}

func +(left:CGPoint, right:CGPoint)->CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y);
}

func +=(left:inout CGPoint, right:CGPoint) {
    left = left + right;
}

func -(left:CGPoint, right:CGPoint)->CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y);
}

func -=(left:inout CGPoint, right:CGPoint) {
    left = left - right;
}

func *(left:CGPoint, right: Int) -> CGPoint {
    return CGPoint(x: left.x * CGFloat(right), y: left.y * CGFloat(right));
}

func *=(left:inout CGPoint, right: Int) {
    left = left * right;
}

func *(left:Int, right: CGPoint) -> CGPoint {
    return CGPoint(x: CGFloat(left) * right.x, y: CGFloat(left) * right.y);
}

func /(left:CGPoint, right: Int) -> CGPoint {
    return CGPoint(x: left.x / CGFloat(right), y: left.y / CGFloat(right));
}

func /=(left:inout CGPoint, right: Int) {
    left = left / right;
}

func *(left:CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right);
}

func *=(left:inout CGPoint, right: CGFloat) {
    left = left * right;
}

func *(left:CGFloat, right: CGPoint) -> CGPoint {
    return CGPoint(x: left * right.x, y: left * right.y);
}

func /(left:CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right);
}

func /=(left:inout CGPoint, right: CGFloat) {
    left = left / right;
}



