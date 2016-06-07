//
//  GameViewController.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/3/16.
//  Copyright (c) 2016 Jeffery Kelly. All rights reserved.
//

import UIKit
import SpriteKit

protocol GameManager {
    func loadLevel(scene:JDScene);
    var prevLevel:Int {get};
    var player:Player {get set};
    func playSong(songNamed:String);
    func stopSong();
}
class GameViewController: UIViewController, GameManager {
    var curScene: SKScene!;
    var lastLevel = 0;
    var prevLevel: Int {
        get {
            return lastLevel;
        }
    }
    
    var playerCharacter: Player = Player();
    
    var player: Player {
        get {
            return playerCharacter;
        }
        
        set {
            playerCharacter = newValue;
        }
    }
    
    var bgm:SKAudioNode?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
     
        loadLevel(MainMenu());
    }
    
    func loadLevel(scene: JDScene) {
        
        if let gameScene = scene as? GameScene {
            lastLevel += 1;
            gameScene.floorNumber = lastLevel;
        } else if curScene is GameOverScene {
            lastLevel = 0;
        }
        self.curScene = scene;
        scene.gameManager = self;
        let skView = self.view as! SKView;
        scene.scaleMode = .AspectFill;
        scene.size = CGSizeMake(1024, 768);
        skView.presentScene(scene);
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        curScene.pressesBegan(presses, withEvent: event);
    }
    
    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        curScene.pressesEnded(presses, withEvent: event);
    }
    
    func playSong(songNamed: String) {
        if let musicUrl = NSBundle.mainBundle().URLForResource(songNamed, withExtension: ".mp3") {
            bgm?.removeFromParent();
            bgm = SKAudioNode(URL: musicUrl);
            (view as! SKView).scene?.addChild(bgm!);
        }
    }
    
    func stopSong() {
        bgm?.removeFromParent();
    }
}
