//
//  tvOS-Extensions.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/7/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

extension GameScene {
       override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        guard let press = presses.first else {
            return;
        }
        
        var testPos = player.position;
        var isDirection:Bool = true;
        switch press.type {
        case .UpArrow:
            testPos = CGPointMake(0, 32);
            break;
        case .DownArrow:
            testPos = CGPointMake(0, -32);
            break;
        case .RightArrow:
            testPos = CGPointMake(32, 0);
            break;
        case .LeftArrow:
            testPos = CGPointMake(-32, 0);
            break;
        default:
            isDirection = false;
            break;
            
        }
        
        if (isDirection) {
            movePlayer(testPos);
        } else if (press.type == .Select) {
            attack();
        }
        
        
    }
}

extension MainMenu {
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        guard let press = presses.first else {
            return;
        }
        
        switch press.type {
        case .UpArrow, .DownArrow:
            changeSelection();
            break;
        case .Select:
            if let selected = childNodeWithName("selected") as? JDButtonNode {
                selected.onClick();
            }
        default:
            break;
        }
    }
    
    func changeSelection() {
        if (startButton.name == "selected") {
            htpButton.name = "selected";
            htpButton.fontColor = SKColor.blackColor();
            //htpButton.fontSize = ProjectConstants.UILabelSize * 1.5;
            htpButton.setScale(1.5);
            startButton.name = "unselected";
            startButton.fontColor = SKColor.whiteColor();
            startButton.fontSize = ProjectConstants.UILabelSize;
            startButton.setScale(1);
        } else {
            startButton.name = "selected";
            startButton.setScale(1.5);
            startButton.fontColor = SKColor.blackColor();
            //startButton.fontSize = ProjectConstants.UILabelSize * 1.5;
            htpButton.name = "unselected";
            htpButton.fontColor = SKColor.whiteColor();
            htpButton.fontSize = ProjectConstants.UILabelSize;
            htpButton.setScale(1);
        }
        
        runAction(SKAction.playSoundFileNamed("menu-select.wav", waitForCompletion: false));
    }
}