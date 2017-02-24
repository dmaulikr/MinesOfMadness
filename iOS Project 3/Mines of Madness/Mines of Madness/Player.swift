//
//  Player.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/3/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

class Player: SKSpriteNode {
    var gameScene: GameScene!;
    let myLight = SKLightNode();
    var maxTorchEnergy: Int = 50;
    let maxLight:CGFloat = 4;
    var torchEnergy:Int = 50 {
        didSet {
            torchEnergy.clamp(min: 0, max: maxTorchEnergy);
        
            if (torchEnergy == 0) {
                sanity -= 1;
            }
            myLight.falloff = maxLight - ((CGFloat(torchEnergy) / CGFloat(maxTorchEnergy)) * (maxLight - 1));
            
            gameScene.lanternTimeLabel.text = "Lantern: \(torchEnergy)";
        }
    }
    
    var maxHP:Int = 25;
    var hp:Int = 25 {
        didSet {
            hp.clamp(min: 0, max: maxHP);
            gameScene.hpLabel.text = "HP: \(hp)";
            
            if (hp == 0) {
                gameScene.gameOver();
            }
        }
    }
    
    var maxSanity:Int = 25;
    var sanity:Int = 25 {
        didSet {
            sanity.clamp(min: 0, max: maxSanity);
            gameScene.sanityLabel.text = "SAN: \(sanity)";
            
            if (sanity == 0) {
                hp -= 1;
            }
        }
    }
    init() {
        let tex = SKTexture(imageNamed: "player");
        super.init(texture: tex, color: SKColor.clear, size:tex.size());
        physicsBody = SKPhysicsBody(rectangleOf: tex.size());
        physicsBody?.affectedByGravity = false;
        physicsBody?.categoryBitMask = PhysicsCategories.Player;
        physicsBody?.collisionBitMask = PhysicsCategories.Wall;
        physicsBody?.contactTestBitMask = PhysicsCategories.LevelEnd | PhysicsCategories.OilCan | PhysicsCategories.Enemy | PhysicsCategories.HealthKit | PhysicsCategories.SanityKit;
        
        myLight.lightColor = SKColor.white;
        myLight.categoryBitMask = PhysicsCategories.All;
        myLight.falloff = 1;
        myLight.isEnabled = true;
        addChild(myLight);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
