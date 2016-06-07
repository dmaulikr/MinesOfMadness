//
//  GameScene.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/3/16.
//  Copyright (c) 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;
import GameplayKit;

protocol JDGameScene {
    func movePlayer(pos:CGPoint);
}
class GameScene: JDScene, tileMapDelegate, SKPhysicsContactDelegate, JDGameScene {
    var player:Player!;
    var playerLocation: CGPoint {
        get {
            return player.position;
        }
    }
    var worldGen = levelMaker();
    var worldLayer = SKNode();
    var guiLayer = SKNode();
    var enemyLayer = SKNode();
    var overlayLayer = SKNode();
    var enemies = [Enemy]();

    var floorNumber = 1;
    //MARK: UI Labels
    let lanternTimeLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let hpLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont)
    let sanityLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    
    #if os(iOS)
    let atkLabel = JDButtonNode();
    #endif
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
        worldGen.gameManager = gameManager;
        worldGen.generateLevel(tileTypes.wall.rawValue);
        print("Level Generated");
        worldGen.generateMap();
        print("Map Generated");
        worldGen.presentLayerViaDelegate();
        print("Map Presented");
        worldGen.spawnObstacles();
        print("Obstacles spawned");
        worldGen.generateItems();
        print("Items Generated");
        worldGen.spawnEnemies();
        print("Enemies Generated");
        
        //Generate UI
        lanternTimeLabel.position = CGPoint(x: 0, y: size.height * 3 / 8);
        lanternTimeLabel.horizontalAlignmentMode = .Center;
        lanternTimeLabel.zPosition = 10;
        lanternTimeLabel.fontColor = SKColor.whiteColor();
        lanternTimeLabel.fontSize = ProjectConstants.UILabelSize;
        lanternTimeLabel.text = "Lantern: \(player.torchEnergy)";
        overlayLayer.addChild(lanternTimeLabel);
        
        hpLabel.position = CGPoint(x: -size.width / 4, y: size.height * 3 / 8);
        hpLabel.horizontalAlignmentMode = .Center;
        hpLabel.zPosition = 10;
        hpLabel.fontColor = SKColor.whiteColor();
        hpLabel.fontSize = ProjectConstants.UILabelSize;
        hpLabel.text = "HP: \(player.hp)";
        overlayLayer.addChild(hpLabel);
        
        sanityLabel.position = CGPoint(x: size.width / 4, y: size.height * 3 / 8);
        sanityLabel.horizontalAlignmentMode = .Center;
        sanityLabel.zPosition = 10;
        sanityLabel.fontColor = SKColor.whiteColor();
        sanityLabel.fontSize = ProjectConstants.UILabelSize;
        sanityLabel.text = "SAN: \(player.sanity)";
        overlayLayer.addChild(sanityLabel);
        
        #if os(iOS)
            atkLabel.text = "ATTACK";
            atkLabel.horizontalAlignmentMode = .Center;
            atkLabel.verticalAlignmentMode = .Center;
            atkLabel.fontColor = SKColor.whiteColor();
            atkLabel.fontSize = ProjectConstants.UILabelSize;
            atkLabel.zPosition = 10;
            atkLabel.position = CGPoint(x:size.width / 4, y: -size.height * 3 / 16);
            atkLabel.setBackgroundSize();
            atkLabel.onClick = {
                self.attack();
            };
            overlayLayer.addChild(atkLabel);
            
            let upArrow = JDArrowButtonNode(rot: 0, scene: self);
            upArrow.position = CGPoint(x: 0, y: 100);
            upArrow.zPosition = 10;
            overlayLayer.addChild(upArrow);
            let downArrow = JDArrowButtonNode(rot: 180, scene: self);
            downArrow.position = CGPoint(x: 0, y: -100);
            downArrow.zPosition = 10;
            overlayLayer.addChild(downArrow);
            let leftArrow = JDArrowButtonNode(rot:90, scene: self);
            leftArrow.position = CGPoint(x: -100, y: 0);
            leftArrow.zPosition = 10;
            overlayLayer.addChild(leftArrow);
            let rightArrow = JDArrowButtonNode(rot:-90, scene: self);
            rightArrow.position = CGPoint(x: 100, y: 0);
            rightArrow.zPosition = 10;
            overlayLayer.addChild(rightArrow);
        #endif
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
        } else if (collision == PhysicsCategories.Player | PhysicsCategories.HealthKit) {
            player.hp += 10;
            
            if (bodyA.node is Player) {
                bodyB.node?.removeFromParent();
            } else {
                bodyA.node?.removeFromParent();
            }
        } else if (collision == PhysicsCategories.Player | PhysicsCategories.SanityKit) {
            player.sanity += 10;
            
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
   
    func movePlayer(pos:CGPoint) {
        let oldPos = player.position;
        let testPos = player.position + pos;
        if (!worldGen.isObstructed(testPos)) {
            player.position = testPos;
            runAction(SKAction.playSoundFileNamed("footsteps.wav", waitForCompletion: false));
            player.torchEnergy -= 1;
            centerCameraOnPoint(player.position);
            
            for enemy in enemies {
                
                enemy.move(worldGen);
                
                if (enemy.position == testPos) {
                    runAction(SKAction.playSoundFileNamed("zombie.wav", waitForCompletion: false));
                    player.hp -= 5;
                    player.position = oldPos;
                }
            }
            if (worldGen.isExit(player.position)) {
                player.removeFromParent();
                gameManager.loadLevel(LevelCompleteScene());
            }
        }
    }
    
    func attack() {
        enumerateChildNodesWithName("obstacle") {
            node, _ in
      
            if (Int(node.position.distance(self.playerLocation)) <= 32) {
                self.worldGen.setTile(position: self.worldGen.worldToGrid(node.position), toValue: tileTypes.grass.rawValue);
                let grass = SKSpriteNode(imageNamed: "tile_grass");
                grass.size = CGSizeMake(32, 32);
                grass.position = node.position;
                grass.zPosition = 1;
                grass.lightingBitMask = PhysicsCategories.Grass;
                self.worldLayer.addChild(grass);

                node.removeFromParent();
            }
        };
        for enemy in enemies {
            if (enemy.position.distance(playerLocation) <= 32) {
                enemy.hp -= 1;
            }
            enemy.move(worldGen);
        }
    }
    
    func gameOver() {
        gameManager.loadLevel(GameOverScene());
    }
    
    //MARK: Level Maker Delegate Functions
    func createNodeOf(type type: tileTypes, location: CGPoint) {
        let randomizer = GKRandomDistribution(forDieWithSideCount: 4);
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
        case .table:
            let node = SKSpriteNode(imageNamed: "table\(randomizer.nextInt())");
            node.name = "obstacle";
            node.size = CGSizeMake(32, 32);
            node.position = location;
            node.zPosition = 1;
            node.zRotation = CGFloat.pi_float * CGFloat(randomizer.nextInt()) / 2;
            node.lightingBitMask = PhysicsCategories.Table;
            addChild(node);
            
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
        enemy.myScene = self;
        enemyLayer.addChild(enemy);
        enemies.append(enemy);
    }
    
    func removeEnemyFromLevel(enemy:Enemy) {
        enemies.removeAtIndex(enemies.indexOf(enemy)!);
        enemy.removeFromParent();
    }
}
