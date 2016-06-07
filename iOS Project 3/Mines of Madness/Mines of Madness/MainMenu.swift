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
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        let titleLabel = SKLabelNode(fontNamed: ProjectConstants.LabelFont);
        titleLabel.text = "Mines of Madness";
        titleLabel.fontColor = SKColor.whiteColor();
        titleLabel.fontSize = 80;
        titleLabel.position = CGPointMake(size.width / 2, size.height * 3 / 4);
        addChild(titleLabel);
        
        
        startButton.text = "Begin Your Descent";
        startButton.fontColor = UIColor.whiteColor();
        startButton.fontSize = ProjectConstants.UILabelSize;
        startButton.horizontalAlignmentMode = .Center;
        startButton.verticalAlignmentMode = .Center;
        startButton.position = CGPointMake(size.width / 2, size.height / 2);
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
        htpButton.fontColor = UIColor.whiteColor();
        htpButton.fontSize = ProjectConstants.UILabelSize;
        htpButton.horizontalAlignmentMode = .Center;
        htpButton.verticalAlignmentMode = .Center;
        htpButton.position = CGPointMake(size.width / 2, size.height / 4);
        htpButton.setBackgroundSize();
        htpButton.onClick = {
            self.gameManager.loadLevel(HowToPlayScene());
        }
        addChild(htpButton);
        
        gameManager.playSong("Thru_The_Fog");
    }
    
    override func willMoveFromView(view: SKView) {
        gameManager.stopSong();
    }
}