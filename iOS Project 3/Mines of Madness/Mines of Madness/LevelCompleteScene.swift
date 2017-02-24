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
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black;
        nextLevelLabel.text = "Tap to descend to the next level";
        nextLevelLabel.fontColor = SKColor.white;
        nextLevelLabel.fontSize = 40;
        nextLevelLabel.position = CGPoint(x: size.width / 2, y: size.height / 4);
        addChild(nextLevelLabel);
        
        congratsLabel.text = "You have cleared Floor \(gameManager.prevLevel)";
        congratsLabel.fontColor = SKColor.white;
        congratsLabel.fontSize = 40;
        congratsLabel.position = CGPoint(x: size.width / 2, y: size.height * 3 / 4);
        addChild(congratsLabel);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch");
        gameManager.loadLevel(GameScene());
    }
}
