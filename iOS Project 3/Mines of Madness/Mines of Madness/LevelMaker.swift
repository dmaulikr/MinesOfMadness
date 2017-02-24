//
//  LevelMaker.swift
//  Mines of Madness
//
//  Created by Jeffery Kelly on 5/3/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//
import SpriteKit;
import GameplayKit;

protocol tileMapDelegate {
    func createNodeOf(type:tileTypes, location:CGPoint);
    func addItemToLevel(_ item:SKSpriteNode);
    func addEnemyToLevel(_ enemy:Enemy);
}

struct levelMaker {
    var delegate: tileMapDelegate?;
    var gameManager: GameManager?;
    var tiles:[[Int]] = Array();
    var mapSize = CGPoint(x: 20, y: 20);
    let minDistanceBetweenEntranceAndExit:CGFloat = 8;
    var entrancePosition:CGPoint!;
    var exitPosition:CGPoint!;
    var numberOfOilCans = 5;
    var numberOfEnemies = 3;
    var maxNumberOfObstacles = 10;
    var minDistanceBetweenOilCanAndEntrance:CGFloat = 5;
    var minDistanceBetweenEnemyAndEntrance:CGFloat = 6;
    var grassTiles = [CGPoint]();
    mutating func generateLevel(_ defaultValue:Int) {
        grassTiles = [CGPoint]();
        var columnArray:[[Int]] = Array();
        
        repeat {
            var rowArray:[Int] = Array();
            
            repeat {
                rowArray.append(defaultValue);
            } while rowArray.count < Int(mapSize.x);
            columnArray.append(rowArray);
        } while columnArray.count < Int(mapSize.y);
        tiles = columnArray;
    }
    
    func isValidTile(position: CGPoint)->Bool {
        return position.x.between(1, max: mapSize.x - 2) && position.y.between(1, max: mapSize.y - 2);
    }
    
    mutating func setTile(position:CGPoint, toValue: Int) {
        tiles[Int(position.y)][Int(position.x)] = toValue;
    }
    
    func getTile(position:CGPoint) -> Int {
        return tiles[Int(position.y)][Int(position.x)];
    }
    
    func tileMapSize() -> CGSize {
        return CGSize(width: ProjectConstants.TileWidth * mapSize.x, height: ProjectConstants.TileHeight * mapSize.y);
    }
    
    mutating func generateMap() {
        
        var currentLocation = CGPoint(x: GKGaussianDistribution(lowestValue: 2, highestValue: Int(mapSize.x) - 2).nextInt(), y: GKGaussianDistribution(lowestValue: 2, highestValue: Int(mapSize.y) - 2).nextInt());
        setTile(position: currentLocation, toValue: tileTypes.levelStart.rawValue);
        entrancePosition = currentLocation;
        let generators = [GKGaussianDistribution(forDieWithSideCount: 4), GKShuffledDistribution(forDieWithSideCount: 4), GKRandomDistribution(forDieWithSideCount: 4)];
        let generatorPicker = GKRandomDistribution(forDieWithSideCount: generators.count);
        
        let movementsPerSet = 35;
        let numberOfSets = 15;
        let patternPicker = GKShuffledDistribution(forDieWithSideCount: 4);
     
        for i in (0...numberOfSets).reversed() {
            let currentGen = generators[generatorPicker.nextInt() - 1];
            let currentPattern = [patternPicker.nextInt(), patternPicker.nextInt(), patternPicker.nextInt(), patternPicker.nextInt()];
            for j in (0...movementsPerSet).reversed() {
                var newPosition = CGPoint.zero;
                let direction = currentPattern[currentGen.nextInt() - 1];
                switch direction {
                case 1:
                    newPosition = CGPoint(x: currentLocation.x, y: currentLocation.y - 1);
                    break;
                case 2:
                    newPosition = CGPoint(x: currentLocation.x, y: currentLocation.y + 1);
                    break;
                case 3:
                    newPosition = CGPoint(x: currentLocation.x - 1, y: currentLocation.y);
                    break;
                case 4:
                    newPosition = CGPoint(x: currentLocation.x + 1, y: currentLocation.y);
                    break;
                default:
                    break;
                }
                
                if i + j == 0 {
                    let exitPt = GKGaussianDistribution(forDieWithSideCount: grassTiles.count).nextInt() - 1;
                    currentLocation = grassTiles[exitPt];
                    grassTiles.remove(at: exitPt);
                    exitPosition = currentLocation;
                    setTile(position: currentLocation, toValue: tileTypes.levelExit.rawValue);
                } else if isValidTile(position: newPosition) {
                    if getTile(position: newPosition) < 2 {
                        currentLocation = newPosition;
                         if (i + j > 0) {
                            if (arc4random_uniform(50) > 0) {
                                setTile(position: currentLocation, toValue: tileTypes.grass.rawValue);
                                
                                if (currentLocation.distance(entrancePosition) >= minDistanceBetweenEntranceAndExit) {
                                   grassTiles.append(currentLocation);
                                }
                            } else {
                                setTile(position: currentLocation, toValue: tileTypes.table.rawValue);
                            }
                        }
                    }
                }
            }
        }
    }
    
    mutating func generateItems() {
        var previousCanPositions = [CGPoint]();
        var itemRandomizer = GKRandomDistribution(forDieWithSideCount: 3);
        func isFarEnoughAwayFromCans(_ oct:CGPoint) -> Bool {
            if (previousCanPositions.isEmpty) {
                return true;
            }
            
            for dt in previousCanPositions {
                if (dt.distance(oct) < 9) {
                    return false;
                }
            }
            
            return true;
        }
        for _ in 0..<numberOfOilCans {
            let dis = GKGaussianDistribution(forDieWithSideCount: grassTiles.count);
            var grassPt = 0;
            var pt = CGPoint.zero;
            var attempts = 0;
            repeat {
                grassPt = dis.nextInt() - 1;
                pt = grassTiles[grassPt];
                attempts += 1;
            } while (!(entrancePosition.distance(pt) >= minDistanceBetweenOilCanAndEntrance && attempts >= 5) || pt == exitPosition);
                
            var item = SKSpriteNode();
            switch (itemRandomizer.nextInt()) {
            case 1:
                item = SKSpriteNode(imageNamed: "oil can");
                item.lightingBitMask = PhysicsCategories.OilCan;
                item.physicsBody = SKPhysicsBody(rectangleOf: item.size);
                item.physicsBody?.categoryBitMask = PhysicsCategories.OilCan;
                break;
            case 2:
                item = SKSpriteNode(imageNamed: "health_kit");
                item.lightingBitMask = PhysicsCategories.HealthKit;
                item.physicsBody = SKPhysicsBody(rectangleOf: item.size);
                item.physicsBody?.categoryBitMask = PhysicsCategories.HealthKit;
                break;
            case 3:
                item = SKSpriteNode(imageNamed: "sanity_kit");
                item.lightingBitMask = PhysicsCategories.SanityKit;
                item.physicsBody = SKPhysicsBody(rectangleOf: item.size);
                item.physicsBody?.categoryBitMask = PhysicsCategories.SanityKit;
                break;
            default:
                break;
            }
            
            item.physicsBody?.affectedByGravity = false;
            item.physicsBody?.isDynamic = false;
            item.position = CGPoint(x: pt.x * ProjectConstants.TileWidth, y: -pt.y * ProjectConstants.TileHeight);
            item.zPosition = 5;
            delegate?.addItemToLevel(item);
            previousCanPositions.append(pt);
            grassTiles.remove(at: grassPt);
        }
    }
    
    mutating func spawnObstacles() {
        var numTables = 0;
        var toRemove = [CGPoint]();
        for pt in grassTiles {
            if IsChokePoint(pt) {
                setTile(position: pt, toValue: tileTypes.table.rawValue);
                delegate?.createNodeOf(type: tileTypes.table, location: CGPoint(x:ProjectConstants.TileWidth * pt.x, y: ProjectConstants.TileHeight * -pt.y));
                numTables += 1;
                toRemove.append(pt);
                if (numTables == maxNumberOfObstacles) {
                    break;
                }
            }
        }
        
        for p in toRemove {
            grassTiles.remove(at: grassTiles.index(of: p)!);
        }
    }
    
    fileprivate func IsChokePoint(_ pt:CGPoint) -> Bool {
        let left = pt - CGPoint(x: 1, y: 0);
        let right = pt + CGPoint(x: 1, y: 0);
        let up = pt + CGPoint(x: 0, y: 1);
        let down = pt - CGPoint(x: 0, y: 1);
        
        return (isWallLoc(left) && isWallLoc(right) && isGrass(up) && isGrass(down)) || (isWallLoc(up) && isWallLoc(down) && isGrass(left) && isGrass(right));
    }
    
    mutating func spawnEnemies() {
        if let gm = gameManager {
            numberOfEnemies = (gm.prevLevel + 1) * 3;
        }
        for _ in 0..<numberOfEnemies {
            let grassPt = GKGaussianDistribution(forDieWithSideCount: grassTiles.count).nextInt();
            var pt = CGPoint.zero;
            repeat {
                pt = grassTiles[grassPt];
            } while (!(entrancePosition.distance(pt) >= minDistanceBetweenEnemyAndEntrance));
            
            
            let enemy = Enemy();
            enemy.position = CGPoint(x: pt.x * ProjectConstants.TileWidth, y: -pt.y * ProjectConstants.TileHeight);
            enemy.zPosition = 5;
            delegate?.addEnemyToLevel(enemy);
            grassTiles.remove(at: grassPt);
        }
    }
    
    func isObstructed(_ point:CGPoint) -> Bool {
        let pt = worldToGrid(point);
        
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && (getTile(position: pt) == tileTypes.wall.rawValue || getTile(position: pt) == tileTypes.table.rawValue);
    }
    func isWall(_ point:CGPoint) -> Bool {
        
        let pt = worldToGrid(point);
        
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && getTile(position: pt) == tileTypes.wall.rawValue;
    }
    
    fileprivate func isWallLoc(_ pt:CGPoint) -> Bool {
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && getTile(position: pt) == tileTypes.wall.rawValue;
    }
    fileprivate func isGrass(_ pt:CGPoint) -> Bool {
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && getTile(position: pt) == tileTypes.grass.rawValue;
    }
    
    func isExit(_ point:CGPoint) -> Bool {
        
        let pt = worldToGrid(point);
        
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && getTile(position: pt) == tileTypes.levelExit.rawValue;
    }
    
    func presentLayerViaDelegate() {
        for (indexr, row) in tiles.enumerated() {
            for (indexc, cvalue) in row.enumerated() {
                delegate?.createNodeOf(type: tileTypes(rawValue: cvalue)!, location: CGPoint(x:ProjectConstants.TileWidth * CGFloat(indexc), y: ProjectConstants.TileHeight * CGFloat(-indexr)));
            }
        }
    }
    
    //MARK: Convert Between Grid and World
    func worldToGrid(_ pt:CGPoint) -> CGPoint {
        let ax = CGFloat(floor(pt.x / ProjectConstants.TileWidth));
        let ay = CGFloat(floor(-pt.y / ProjectConstants.TileHeight));
        return CGPoint(x: Int(ax), y:Int(ay));
    }
    
    func gridToWorld(_ pt:CGPoint) -> CGPoint {
        return CGPoint(x: pt.x * ProjectConstants.TileWidth, y: -pt.y * ProjectConstants.TileHeight);
    }
}
