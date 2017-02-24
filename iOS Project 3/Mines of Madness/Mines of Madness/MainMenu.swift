//
//  MainMenu.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/3/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class MainMenu: JDScene {
    let startButton = JDButtonNode();
    let htpButton = JDButtonNode();
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black;
        let titleLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
        titleLabel.text = "Mines of Madness";
        titleLabel.fontColor = SKColor.white;
        titleLabel.fontSize = 80;
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height * 3 / 4);
        addChild(titleLabel);
        
        
        startButton.text = "Begin Your Descent";
        startButton.fontColor = UIColor.white;
        startButton.fontSize = ProjectConstants.UILabelSize;
        startButton.horizontalAlignmentMode = .center;
        startButton.verticalAlignmentMode = .center;
        startButton.position = CGPoint(x: size.width / 2, y: size.height / 2);
        startButton.setBackgroundSize();
        startButton.onClick = {
            self.gameManager.loadLevel(GameScene());
        }
        addChild(startButton);
        #if os(tvOS)
            startButton.name = "selected";
            startButton.setScale(1.5);
            startButton.fontColor = SKColor.blackColor();
        #endif
        
        htpButton.text = "How To Play";
        htpButton.fontColor = UIColor.white;
        htpButton.fontSize = ProjectConstants.UILabelSize;
        htpButton.horizontalAlignmentMode = .center;
        htpButton.verticalAlignmentMode = .center;
        htpButton.position = CGPoint(x: size.width / 2, y: size.height / 4);
        htpButton.setBackgroundSize();
        htpButton.onClick = {
            self.gameManager.loadLevel(HowToPlayScene());
        }
        addChild(htpButton);
        
        gameManager.playSong("Thru_The_Fog");
    }
    
    override func willMove(from view: SKView) {
        gameManager.stopSong();
    }
}
