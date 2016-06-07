//
//  JDUtils.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/3/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

struct ProjectConstants {
    static let LabelFont = "Blood Crow";
    static let UILabelSize:CGFloat = 30;
    static let ButtonPaddingX:CGFloat = 10;
    static let ButtonPaddingY:CGFloat = 10;
    static let TileSize:CGSize = CGSizeMake(32, 32);
    static var TileWidth:CGFloat {
        get {
            return TileSize.width;
        }
    }
    
    static var TileHeight:CGFloat {
        get {
            return TileSize.height;
        }
    }
}
struct PhysicsCategories {
    static let None:UInt32 = 0;
    static let Player: UInt32 = 0b1;
    static let Wall: UInt32 = 0b10;
    static let LevelEnd: UInt32 = 0b100;
    static let LevelEntrance: UInt32 = 0b1000;
    static let Grass: UInt32 = 0b10000;
    static let OilCan: UInt32 = 0b100000;
    static let HealthKit: UInt32 = 0b1000000;
    static let SanityKit: UInt32 = 0b10000000;
    static let Enemy: UInt32 = 0b100000000;
    static let Table: UInt32 = 0b1000000000;
    static let All: UInt32 = UInt32.max;
}

enum tileTypes: Int {
    case grass = 0
    case wall = 1
    case levelExit = 2
    case levelStart = 3
    case table = 4
}