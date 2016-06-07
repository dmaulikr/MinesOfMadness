//
//  JDButtonNode.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/7/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

protocol JDButton {
    var onClick:()->() {set get};
}
class JDButtonNode:SKLabelNode, JDButton {
    var bgRect:SKShapeNode?;
    var onClick: () -> () = {};
    override init() {
        super.init();
        fontName = ProjectConstants.LabelFont;
        userInteractionEnabled = true;
    }
    
    func setBackgroundSize() {
        bgRect = SKShapeNode(rectOfSize: frame.size + CGSizeMake(ProjectConstants.ButtonPaddingX * 2, ProjectConstants.ButtonPaddingY * 2));
        bgRect?.fillColor = SKColor.redColor();
        bgRect?.zPosition = -1;
        addChild(bgRect!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        #if os(iOS)
        onClick();
        #endif
    }
}