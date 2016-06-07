//
//  GameOverScene.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/7/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

class GameOverScene: JDScene {
    let goLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let restartLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    let reachLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        
        goLabel.text = "Game Over";
        goLabel.fontColor = SKColor.whiteColor();
        goLabel.fontSize = ProjectConstants.UILabelSize;
        goLabel.position = CGPointMake(size.width / 2, size.height * 3 / 4);
        goLabel.horizontalAlignmentMode = .Center;
        addChild(goLabel);
        
        reachLabel.text = "You made it to level \(gameManager.prevLevel) but you could go no farther.";
        reachLabel.fontColor = SKColor.whiteColor();
        reachLabel.fontSize = ProjectConstants.UILabelSize;
        reachLabel.position = CGPointMake(size.width / 2, size.height / 2);
        reachLabel.horizontalAlignmentMode = .Center;
        addChild(reachLabel);
        
        restartLabel.text = "Tap to return to the main menu";
        restartLabel.fontColor = SKColor.whiteColor();
        restartLabel.fontSize = ProjectConstants.UILabelSize;
        restartLabel.position = CGPointMake(size.width / 2, size.height / 4);
        restartLabel.horizontalAlignmentMode = .Center;
        addChild(restartLabel);

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        gameManager.loadLevel(MainMenu());
    }
    
    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        gameManager.loadLevel(MainMenu());
    }
}
