//
//  Enemy.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/5/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;
import GameplayKit;

class Enemy: SKSpriteNode {
    var myScene:GameScene!;
    var hp = 1 {
        didSet {
            if (hp <= 0) {
                myScene.removeEnemyFromLevel(self);
            }
        }
    }
    init() {
        let tex = SKTexture(imageNamed: "enemy");
        super.init(texture: tex, color: SKColor.clear, size: tex.size());
        physicsBody = SKPhysicsBody(rectangleOf: tex.size());
        physicsBody?.affectedByGravity = false;
        physicsBody?.isDynamic = false;
        physicsBody?.categoryBitMask = PhysicsCategories.Enemy;
        lightingBitMask = PhysicsCategories.Enemy;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(_ lm:levelMaker) {
        let gen = GKShuffledDistribution(forDieWithSideCount: 4);
        var testPos = position;
        repeat {
            let dir = gen.nextInt();
            
            switch dir {
            case 1:
                testPos = position + CGPoint(x: 0, y: 32);
                break;
            case 2:
                testPos = position + CGPoint(x: 0, y: -32);
                break;
            case 3:
                testPos = position + CGPoint(x: 32, y: 0);
                break;
            case 4:
                testPos = position + CGPoint(x: -32, y: 0);
                break;
            default:
                break;
            }
        } while (lm.isObstructed(testPos));
        
        if (myScene.playerLocation.distance(position) == 32) {
            myScene.player.hp -= 1;
        }
        position = testPos;
    }
}
