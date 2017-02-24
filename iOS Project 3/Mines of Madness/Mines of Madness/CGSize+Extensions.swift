//
//  CGSize+Extensions.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/7/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

func +(left:CGSize, right:CGSize)->CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height);
}

func +=(left:inout CGSize, right:CGSize) {
    left = left + right;
}

func -(left:CGSize, right:CGSize)->CGSize {
    return CGSize(width: left.width - right.width, height: left.height - right.height);
}

func -=(left:inout CGSize, right:CGSize) {
    left = left - right;
}

func *(left:CGSize, right: Int) -> CGSize {
    return CGSize(width: left.width * CGFloat(right), height: left.height * CGFloat(right));
}

func *=(left:inout CGSize, right: Int) {
    left = left * right;
}

func *(left:Int, right: CGSize) -> CGSize {
    return CGSize(width: CGFloat(left) * right.width, height: CGFloat(left) * right.height);
}

func /(left:CGSize, right: Int) -> CGSize {
    return CGSize(width: left.width / CGFloat(right), height: left.height / CGFloat(right));
}

func /=(left:inout CGSize, right: Int) {
    left = left / right;
}

func *(left:CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right);
}

func *=(left:inout CGSize, right: CGFloat) {
    left = left * right;
}

func *(left:CGFloat, right: CGSize) -> CGSize {
    return CGSize(width: left * right.width, height: left * right.height);
}

func /(left:CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width / right, height: left.height / right);
}

func /=(left:inout CGSize, right: CGFloat) {
    left = left / right;
}
