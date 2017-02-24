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
    func loadLevel(_ scene:JDScene);
    var prevLevel:Int {get};
    var player:Player {get set};
    func playSong(_ songNamed:String);
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
    
    func loadLevel(_ scene: JDScene) {
        
        if let gameScene = scene as? GameScene {
            lastLevel += 1;
            gameScene.floorNumber = lastLevel;
        } else if curScene is GameOverScene {
            lastLevel = 0;
        }
        self.curScene = scene;
        scene.gameManager = self;
        let skView = self.view as! SKView;
        scene.scaleMode = .aspectFill;
        scene.size = CGSize(width: 1024, height: 768);
        skView.presentScene(scene);
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        curScene.pressesBegan(presses, with: event);
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        curScene.pressesEnded(presses, with: event);
    }
    
    func playSong(_ songNamed: String) {
        if let musicUrl = Bundle.main.url(forResource: songNamed, withExtension: ".mp3") {
            bgm?.removeFromParent();
            bgm = SKAudioNode(url: musicUrl);
            (view as! SKView).scene?.addChild(bgm!);
        }
    }
    
    func stopSong() {
        bgm?.removeFromParent();
    }
}
