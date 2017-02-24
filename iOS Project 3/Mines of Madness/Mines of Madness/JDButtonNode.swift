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
        isUserInteractionEnabled = true;
    }
    
    func setBackgroundSize() {
        bgRect = SKShapeNode(rectOf: frame.size + CGSize(width: ProjectConstants.ButtonPaddingX * 2, height: ProjectConstants.ButtonPaddingY * 2));
        bgRect?.fillColor = SKColor.red;
        bgRect?.zPosition = -1;
        addChild(bgRect!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        #if os(iOS)
        onClick();
        #endif
    }
}
