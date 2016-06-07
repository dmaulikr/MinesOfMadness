//
//  HowToPlayScene.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/8/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

class HowToPlayScene:JDScene {
    let player = SKSpriteNode(imageNamed: "player");
    let upLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let downLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let leftLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let rightLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let atkLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    override func didMoveToView(view: SKView) {
        let cen = CGPointMake(size.width / 2, size.height / 2);
        
        
        player.setScale(2);
        player.position = cen;
        addChild(player);
        
        let htpLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
        htpLabel.text = "How To Play";
        htpLabel.fontSize = ProjectConstants.UILabelSize;
        htpLabel.fontColor = SKColor.whiteColor();
        htpLabel.position = CGPointMake(size.width / 2, size.height * 13 / 16);
        addChild(htpLabel);
        
        let tapLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
        tapLabel.text = "Tap To Move";
        tapLabel.fontSize = ProjectConstants.UILabelSize;
        tapLabel.fontColor = SKColor.whiteColor();
        addChild(tapLabel);
        
        tapLabel.position = cen + CGPointMake(0, 100);
        
        
        upLabel.text = "UP";
        upLabel.fontSize = ProjectConstants.UILabelSize;
        upLabel.fontColor = SKColor.whiteColor();
        upLabel.position = cen + CGPointMake(0, 50);
        addChild(upLabel);
        
        downLabel.text = "DOWN";
        downLabel.fontSize = ProjectConstants.UILabelSize;
        downLabel.fontColor = SKColor.whiteColor();
        downLabel.position = cen - CGPointMake(0, 75);
        addChild(downLabel);
        
        leftLabel.text = "LEFT";
        leftLabel.fontSize = ProjectConstants.UILabelSize;
        leftLabel.fontColor = SKColor.whiteColor();
        leftLabel.position = cen - CGPointMake(size.width / 8, 0);
        addChild(leftLabel);
        
        rightLabel.text = "RIGHT";
        rightLabel.fontSize = ProjectConstants.UILabelSize;
        rightLabel.fontColor = SKColor.whiteColor();
        rightLabel.position = cen + CGPointMake(size.width / 8, 0);
        addChild(rightLabel);
        
        atkLabel.text = "Click to Attack";
        atkLabel.position = cen - CGPointMake(0, 200);
        atkLabel.fontColor = SKColor.whiteColor();
        atkLabel.fontSize = ProjectConstants.UILabelSize;
        addChild(atkLabel);
        
        
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        guard let press = presses.first else {
            return;
        }
        
        switch press.type {
        case .UpArrow:
            upLabel.fontColor = SKColor.redColor();
            runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({self.upLabel.fontColor = SKColor.whiteColor()})]));
            break;
        case .DownArrow:
            downLabel.fontColor = SKColor.redColor();
            runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({self.downLabel.fontColor = SKColor.whiteColor()})]));
            break;
        case .LeftArrow:
            leftLabel.fontColor = SKColor.redColor();
            runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({self.leftLabel.fontColor = SKColor.whiteColor()})]));
            break;
        case .RightArrow:
            rightLabel.fontColor = SKColor.redColor();
            runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({self.rightLabel.fontColor = SKColor.whiteColor()})]));
            break;
        case .Select:
            atkLabel.fontColor = SKColor.redColor();
            runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({self.atkLabel.fontColor = SKColor.whiteColor()})]));
            break;
        case .Menu:
            gameManager.loadLevel(MainMenu());
        default:
            break;
        }
    }
}