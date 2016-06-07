//
//  CGSize+Extensions.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/7/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

func +(left:CGSize, right:CGSize)->CGSize {
    return CGSizeMake(left.width + right.width, left.height + right.height);
}

func +=(inout left:CGSize, right:CGSize) {
    left = left + right;
}

func -(left:CGSize, right:CGSize)->CGSize {
    return CGSizeMake(left.width - right.width, left.height - right.height);
}

func -=(inout left:CGSize, right:CGSize) {
    left = left - right;
}

func *(left:CGSize, right: Int) -> CGSize {
    return CGSizeMake(left.width * CGFloat(right), left.height * CGFloat(right));
}

func *=(inout left:CGSize, right: Int) {
    left = left * right;
}

func *(left:Int, right: CGSize) -> CGSize {
    return CGSizeMake(CGFloat(left) * right.width, CGFloat(left) * right.height);
}

func /(left:CGSize, right: Int) -> CGSize {
    return CGSizeMake(left.width / CGFloat(right), left.height / CGFloat(right));
}

func /=(inout left:CGSize, right: Int) {
    left = left / right;
}

func *(left:CGSize, right: CGFloat) -> CGSize {
    return CGSizeMake(left.width * right, left.height * right);
}

func *=(inout left:CGSize, right: CGFloat) {
    left = left * right;
}

func *(left:CGFloat, right: CGSize) -> CGSize {
    return CGSizeMake(left * right.width, left * right.height);
}

func /(left:CGSize, right: CGFloat) -> CGSize {
    return CGSizeMake(left.width / right, left.height / right);
}

func /=(inout left:CGSize, right: CGFloat) {
    left = left / right;
}
