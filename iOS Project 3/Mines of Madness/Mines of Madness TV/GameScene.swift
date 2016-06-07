//
//  GameScene.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/3/16.
//  Copyright (c) 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class GameScene: JDScene, tileMapDelegate, SKPhysicsContactDelegate {
    var player:Player!;
    var worldGen = levelMaker();
    var worldLayer = SKNode();
    var guiLayer = SKNode();
    var enemyLayer = SKNode();
    var overlayLayer = SKNode();
    var enemies = [Enemy]();
    var floorNumber = 1;
    
    var lastTouchedSquare:SKSpriteNode?;
    //MARK: UI Labels
    let lanternTimeLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    //MARK: didMoveToView
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        let myCamera = SKCameraNode();
        camera = myCamera;
        myCamera.setScale(0.44);
        addChild(myCamera);
        addChild(worldLayer);
        camera!.addChild(guiLayer);
        guiLayer.addChild(overlayLayer);
        worldLayer.addChild(enemyLayer);
        
        physicsWorld.contactDelegate = self;
        physicsWorld.gravity = CGVector.zero;
        worldGen.delegate = self;
        worldGen.generateLevel(tileTypes.wall.rawValue);
        print("Level Generated");
        worldGen.generateMap();
        print("Map Generated");
        worldGen.presentLayerViaDelegate();
        print("Map Presented");
        worldGen.generateItems();
        print("Items Generated");
        worldGen.spawnEnemies();
        print("Enemies Generated");
        
        //Generate UI
        lanternTimeLabel.position = CGPoint(x: 0, y: size.height * 3 / 8);
        lanternTimeLabel.zPosition = 10;
        lanternTimeLabel.fontColor = SKColor.whiteColor();
        lanternTimeLabel.fontSize = 30;
        lanternTimeLabel.text = "Lantern: \(player.torchEnergy)";
        overlayLayer.addChild(lanternTimeLabel);
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let bodyA = contact.bodyA;
        let bodyB = contact.bodyB;
        let collision = bodyA.categoryBitMask | bodyB.categoryBitMask;
        
        if (collision == PhysicsCategories.Player | PhysicsCategories.OilCan) {
            player.torchEnergy += 10;
            
            if (bodyA.node is Player) {
                bodyB.node?.removeFromParent();
            } else {
                bodyA.node?.removeFromParent();
            }
        }
    }
    
    func centerCameraOnPoint(location:CGPoint) {
        if let camera = camera {
            camera.position = location;
        }
    }
    
    //MARK: TV Remote Controls
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        
        let touchDif = touch.locationInNode(self);
        print("Touched At \(touchDif)");
        let touchAng = touchDif.angle.radToDeg;
        print("Angle: \(touchAng)");
        
        var testPos = player.position;
        
        if (touchAng.between(45, max: 135)) {
            testPos += CGPointMake(0, 32);
        } else if (touchAng.between(-135, max: -45)) {
            testPos -= CGPointMake(0, 32);
        } else if (touchAng.between(136, max: 180) || touchAng.between(-180, max: -136)) {
            testPos -= CGPointMake(32, 0);
        } else {
            testPos += CGPointMake(32, 0);
        }
        
        if (!worldGen.isWall(testPos)) {
            lastTouchedSquare?.color = SKColor.clearColor();
            (self.nodeAtPoint(testPos) as! SKSpriteNode).color = SKColor.redColor();
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        guard let press = presses.first else {
            return;
        }
        
        var testPos = player.position;
        switch press.type {
        case .UpArrow:
            testPos += CGPointMake(0, 32);
            print("Up");
            break;
        case .DownArrow:
            testPos -= CGPointMake(0, 32);
            print("Down");
            break;
        case .RightArrow:
            testPos += CGPointMake(32, 0);
            print("Right");
            break;
        case .LeftArrow:
            testPos -= CGPointMake(32, 0);
            print("Left");
            break;
        default:
            break;
            
        }
        
        if (!worldGen.isWall(testPos)) {
            player.position = testPos;
            player.torchEnergy -= 1;
            centerCameraOnPoint(player.position);
            
            for enemy in enemies {
                enemy.move(worldGen);
            }
            if (worldGen.isExit(player.position)) {
                player.removeFromParent();
                gameManager.loadLevel(LevelCompleteScene());
            }
        }
        
        
    }

    
    //MARK: Level Maker Delegate Functions
    func createNodeOf(type type: tileTypes, location: CGPoint) {
        switch type {
        case .grass:
            let node = SKSpriteNode(imageNamed: "tile_grass");
            node.size = CGSizeMake(32, 32);
            node.position = location;
            node.zPosition = 1;
            node.lightingBitMask = PhysicsCategories.Grass;
            worldLayer.addChild(node);
            break;
        case .wall:
            let node = SKSpriteNode(imageNamed: "tile_wall");
            node.size = CGSizeMake(32, 32);
            node.position = location;
            node.zPosition = 1;
            node.lightingBitMask = PhysicsCategories.Wall;
            node.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(origin: CGPointMake(-16, -16), size: CGSizeMake(32, 32)));
            node.physicsBody?.categoryBitMask = PhysicsCategories.Wall;
            
            addChild(node);
            break;
        case .levelStart:
            let node = SKSpriteNode(imageNamed: "door");
            node.size = CGSizeMake(32, 32);
            node.position = location;
            node.zPosition = 1;
            node.lightingBitMask = PhysicsCategories.LevelEntrance;
            worldLayer.addChild(node);
            
            player = gameManager.player;
            player.gameScene = self;
            player.position = location;
            player.zPosition = 50;
            worldLayer.addChild(player);
            
            
            centerCameraOnPoint(location);
            break;
        case .levelExit:
            let node = SKSpriteNode(imageNamed: "door");
            node.size = CGSizeMake(32, 32);
            node.lightingBitMask = PhysicsCategories.LevelEnd;
            node.position = location;
            node.zPosition = 1;
            node.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(origin: CGPointMake(-16, -16), size: CGSizeMake(32, 32)));
            node.physicsBody?.categoryBitMask = PhysicsCategories.LevelEnd;
            worldLayer.addChild(node);
            break;
        }
    }
    
    func addItemToLevel(item: SKSpriteNode) {
        worldLayer.addChild(item);
    }
    
    func addEnemyToLevel(enemy:Enemy) {
        enemy.name = "Enemy";
        enemyLayer.addChild(enemy);
        enemies.append(enemy);
    }
}
