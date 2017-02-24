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
    
    override func didMove(to view: SKView) {
        let cen = CGPoint(x: size.width / 2, y: size.height / 2);
        
        
        player.setScale(2);
        player.position = cen;
        addChild(player);
        
        let htpLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
        htpLabel.text = "How To Play";
        htpLabel.fontSize = ProjectConstants.UILabelSize;
        htpLabel.fontColor = SKColor.white;
        htpLabel.position = CGPoint(x: size.width / 2, y: size.height * 13 / 16);
        addChild(htpLabel);
        
        let tapLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
        tapLabel.text = "Tap To Move";
        tapLabel.fontSize = ProjectConstants.UILabelSize;
        tapLabel.fontColor = SKColor.white;
        addChild(tapLabel);
        
        tapLabel.position = CGPoint(x: size.width / 2, y: size.height * 3 / 4);
        
        
        upLabel.text = "UP";
        upLabel.fontSize = ProjectConstants.UILabelSize;
        upLabel.fontColor = SKColor.white;
        upLabel.position = cen + CGPoint(x: 0, y: 100);
        addChild(upLabel);
        
        downLabel.text = "DOWN";
        downLabel.fontSize = ProjectConstants.UILabelSize;
        downLabel.fontColor = SKColor.white;
        downLabel.position = cen - CGPoint(x: 0, y: 100);
        addChild(downLabel);
        
        leftLabel.text = "LEFT";
        leftLabel.fontSize = ProjectConstants.UILabelSize;
        leftLabel.fontColor = SKColor.white;
        leftLabel.position = cen - CGPoint(x: size.width / 8, y: 0);
        addChild(leftLabel);
        
        rightLabel.text = "RIGHT";
        rightLabel.fontSize = ProjectConstants.UILabelSize;
        rightLabel.fontColor = SKColor.white;
        rightLabel.position = cen + CGPoint(x: size.width / 8, y: 0);
        addChild(rightLabel);
        
        let fakeAtkButton = JDButtonNode();
        fakeAtkButton.text = "ATTACK";
        fakeAtkButton.horizontalAlignmentMode = .center;
        fakeAtkButton.verticalAlignmentMode = .center;
        fakeAtkButton.fontColor = SKColor.white;
        fakeAtkButton.fontSize = ProjectConstants.UILabelSize;
        fakeAtkButton.zPosition = 10;
        fakeAtkButton.position = CGPoint(x:size.width * 7 / 8, y: size.height / 4);
        fakeAtkButton.setBackgroundSize();
        addChild(fakeAtkButton);
        
        let menuButton = JDButtonNode();
        menuButton.text = "Main Menu";
        menuButton.horizontalAlignmentMode = .center;
        menuButton.verticalAlignmentMode = .center;
        menuButton.fontSize = ProjectConstants.UILabelSize;
        menuButton.fontColor = SKColor.white;
        menuButton.position = CGPoint(x: size.width / 8, y: size.height / 4);
        menuButton.setBackgroundSize();
        menuButton.onClick = {
            self.gameManager.loadLevel(MainMenu());
        }
        addChild(menuButton);

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return;
        }
        let touchLocation = touch.location(in: self);
        let touchDifference = touchLocation - player.position;
        let touchAng = touchDifference.angle.radToDeg;
        if (touchAng.between(45, max: 135)) {
            upLabel.fontColor = SKColor.red;
            run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run({self.upLabel.fontColor = SKColor.white})]));
        } else if (touchAng.between(-135, max: -45)) {
            downLabel.fontColor = SKColor.red;
            run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run({self.downLabel.fontColor = SKColor.white})]));
        } else if (touchAng.between(136, max: 180) || touchAng.between(-180, max: -136)) {
            leftLabel.fontColor = SKColor.red;
            run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run({self.leftLabel.fontColor = SKColor.white})]));
        } else {
            rightLabel.fontColor = SKColor.red;
            run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run({self.rightLabel.fontColor = SKColor.white})]));
        }

    }
}
