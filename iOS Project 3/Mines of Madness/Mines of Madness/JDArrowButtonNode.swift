//
//  JDArrowButtonNode.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/13/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

class JDArrowButtonNode: SKSpriteNode, JDButton {
    var onClick: () -> () = {};
    var jScene:JDGameScene;
    init(rot:CGFloat, scene:JDGameScene) {
        jScene = scene;
        let tex = SKTexture.init(imageNamed: "arrow");
        super.init(texture: tex, color: SKColor.white, size: tex.size());
        zRotation = rot.degToRad;
        isUserInteractionEnabled = true;
        onClick = {
            self.jScene.movePlayer(CGPoint.pointFromAngle(rot + 90) * ProjectConstants.TileWidth);
            self.dehighlight();
        }
        colorBlendFactor = 1.0;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func highlight() {
        self.color = SKColor.red;
    }
    
    func dehighlight() {
        self.color = SKColor.white;
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if os(iOS)
            highlight();
        #endif
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if os(iOS)
            guard let touch = touches.first else {
                return;
            }
            
            let pos = touch.location(in: self);
            if (!(pos.x.between(0, max: size.width) && pos.y.between(0, max: size.height))) {
                dehighlight();
            }
        #endif
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if os(iOS)
            onClick();
        #endif
    }
}
