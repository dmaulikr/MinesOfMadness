//
//  HowToPlayScene.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/8/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class HowToPlayScene:JDScene {
    let player = SKSpriteNode(imageNamed: "player");
    let upLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let downLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let leftLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let rightLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    
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
        
        tapLabel.position = CGPointMake(size.width / 2, size.height * 3 / 4);
        
        
        upLabel.text = "UP";
        upLabel.fontSize = ProjectConstants.UILabelSize;
        upLabel.fontColor = SKColor.whiteColor();
        upLabel.position = cen + CGPointMake(0, 100);
        addChild(upLabel);
        
        downLabel.text = "DOWN";
        downLabel.fontSize = ProjectConstants.UILabelSize;
        downLabel.fontColor = SKColor.whiteColor();
        downLabel.position = cen - CGPointMake(0, 100);
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
        
        let fakeAtkButton = JDButtonNode();
        fakeAtkButton.text = "ATTACK";
        fakeAtkButton.horizontalAlignmentMode = .Center;
        fakeAtkButton.verticalAlignmentMode = .Center;
        fakeAtkButton.fontColor = SKColor.whiteColor();
        fakeAtkButton.fontSize = ProjectConstants.UILabelSize;
        fakeAtkButton.zPosition = 10;
        fakeAtkButton.position = CGPoint(x:size.width * 7 / 8, y: size.height / 4);
        fakeAtkButton.setBackgroundSize();
        addChild(fakeAtkButton);
        
        let menuButton = JDButtonNode();
        menuButton.text = "Main Menu";
        menuButton.horizontalAlignmentMode = .Center;
        menuButton.verticalAlignmentMode = .Center;
        menuButton.fontSize = ProjectConstants.UILabelSize;
        menuButton.fontColor = SKColor.whiteColor();
        menuButton.position = CGPointMake(size.width / 8, size.height / 4);
        menuButton.setBackgroundSize();
        menuButton.onClick = {
            self.gameManager.loadLevel(MainMenu());
        }
        addChild(menuButton);

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else {
            return;
        }
        let touchLocation = touch.locationInNode(self);
        let touchDifference = touchLocation - player.position;
        let touchAng = touchDifference.angle.radToDeg;
        if (touchAng.between(45, max: 135)) {
            upLabel.fontColor = SKColor.redColor();
            runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({self.upLabel.fontColor = SKColor.whiteColor()})]));
        } else if (touchAng.between(-135, max: -45)) {
            downLabel.fontColor = SKColor.redColor();
            runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({self.downLabel.fontColor = SKColor.whiteColor()})]));
        } else if (touchAng.between(136, max: 180) || touchAng.between(-180, max: -136)) {
            leftLabel.fontColor = SKColor.redColor();
            runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({self.leftLabel.fontColor = SKColor.whiteColor()})]));
        } else {
            rightLabel.fontColor = SKColor.redColor();
            runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({self.rightLabel.fontColor = SKColor.whiteColor()})]));
        }

    }
}
