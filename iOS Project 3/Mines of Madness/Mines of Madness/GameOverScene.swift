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
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black;
        
        goLabel.text = "Game Over";
        goLabel.fontColor = SKColor.white;
        goLabel.fontSize = ProjectConstants.UILabelSize;
        goLabel.position = CGPoint(x: size.width / 2, y: size.height * 3 / 4);
        goLabel.horizontalAlignmentMode = .center;
        addChild(goLabel);
        
        reachLabel.text = "You made it to level \(gameManager.prevLevel) but you could go no farther.";
        reachLabel.fontColor = SKColor.white;
        reachLabel.fontSize = ProjectConstants.UILabelSize;
        reachLabel.position = CGPoint(x: size.width / 2, y: size.height / 2);
        reachLabel.horizontalAlignmentMode = .center;
        addChild(reachLabel);
        
        restartLabel.text = "Tap to return to the main menu";
        restartLabel.fontColor = SKColor.white;
        restartLabel.fontSize = ProjectConstants.UILabelSize;
        restartLabel.position = CGPoint(x: size.width / 2, y: size.height / 4);
        restartLabel.horizontalAlignmentMode = .center;
        addChild(restartLabel);

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager.loadLevel(MainMenu());
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        gameManager.loadLevel(MainMenu());
    }
}
