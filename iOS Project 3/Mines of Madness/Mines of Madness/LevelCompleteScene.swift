//
//  LevelCompleteScene.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/5/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class LevelCompleteScene: JDScene {
    let nextLevelLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let congratsLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        nextLevelLabel.text = "Tap to descend to the next level";
        nextLevelLabel.fontColor = SKColor.whiteColor();
        nextLevelLabel.fontSize = 40;
        nextLevelLabel.position = CGPointMake(size.width / 2, size.height / 4);
        addChild(nextLevelLabel);
        
        congratsLabel.text = "You have cleared Floor \(gameManager.prevLevel)";
        congratsLabel.fontColor = SKColor.whiteColor();
        congratsLabel.fontSize = 40;
        congratsLabel.position = CGPointMake(size.width / 2, size.height * 3 / 4);
        addChild(congratsLabel);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touch");
        gameManager.loadLevel(GameScene());
    }
}
