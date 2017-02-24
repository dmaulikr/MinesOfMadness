//
//  iOS-Extensions.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/7/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

extension GameViewController {
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

extension GameScene {
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        
        let touchDifference = touchLocation - player.position;
        let touchAng = touchDifference.angle.radToDeg;
        
        var testPos = player.position;
        
        if (touchAng.between(45, max: 135)) {
            testPos = CGPointMake(0, 32);
        } else if (touchAng.between(-135, max: -45)) {
            testPos = CGPointMake(0, -32);
        } else if (touchAng.between(136, max: 180) || touchAng.between(-180, max: -136)) {
            testPos = CGPointMake(-32, 0);
        } else {
            testPos = CGPointMake(32, 0);
        }
        
        movePlayer(testPos);
    }*/
}
