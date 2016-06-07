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
    func createNodeOf(type type:tileTypes, location:CGPoint);
    func addItemToLevel(item:SKSpriteNode);
    func addEnemyToLevel(enemy:Enemy);
}

struct levelMaker {
    var delegate: tileMapDelegate?;
    var gameManager: GameManager?;
    var tiles:[[Int]] = Array();
    var mapSize = CGPointMake(20, 20);
    let minDistanceBetweenEntranceAndExit:CGFloat = 8;
    var entrancePosition:CGPoint!;
    var exitPosition:CGPoint!;
    var numberOfOilCans = 5;
    var numberOfEnemies = 3;
    var maxNumberOfObstacles = 10;
    var minDistanceBetweenOilCanAndEntrance:CGFloat = 5;
    var minDistanceBetweenEnemyAndEntrance:CGFloat = 6;
    var grassTiles = [CGPoint]();
    mutating func generateLevel(defaultValue:Int) {
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
    
    func isValidTile(position position: CGPoint)->Bool {
        return position.x.between(1, max: mapSize.x - 2) && position.y.between(1, max: mapSize.y - 2);
    }
    
    mutating func setTile(position position:CGPoint, toValue: Int) {
        tiles[Int(position.y)][Int(position.x)] = toValue;
    }
    
    func getTile(position position:CGPoint) -> Int {
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
     
        for i in (0...numberOfSets).reverse() {
            let currentGen = generators[generatorPicker.nextInt() - 1];
            let currentPattern = [patternPicker.nextInt(), patternPicker.nextInt(), patternPicker.nextInt(), patternPicker.nextInt()];
            for j in (0...movementsPerSet).reverse() {
                var newPosition = CGPointZero;
                let direction = currentPattern[currentGen.nextInt() - 1];
                switch direction {
                case 1:
                    newPosition = CGPointMake(currentLocation.x, currentLocation.y - 1);
                    break;
                case 2:
                    newPosition = CGPointMake(currentLocation.x, currentLocation.y + 1);
                    break;
                case 3:
                    newPosition = CGPointMake(currentLocation.x - 1, currentLocation.y);
                    break;
                case 4:
                    newPosition = CGPointMake(currentLocation.x + 1, currentLocation.y);
                    break;
                default:
                    break;
                }
                
                if i + j == 0 {
                    let exitPt = GKGaussianDistribution(forDieWithSideCount: grassTiles.count).nextInt() - 1;
                    currentLocation = grassTiles[exitPt];
                    grassTiles.removeAtIndex(exitPt);
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
        func isFarEnoughAwayFromCans(oct:CGPoint) -> Bool {
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
            var pt = CGPointZero;
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
                item.physicsBody = SKPhysicsBody(rectangleOfSize: item.size);
                item.physicsBody?.categoryBitMask = PhysicsCategories.OilCan;
                break;
            case 2:
                item = SKSpriteNode(imageNamed: "health_kit");
                item.lightingBitMask = PhysicsCategories.HealthKit;
                item.physicsBody = SKPhysicsBody(rectangleOfSize: item.size);
                item.physicsBody?.categoryBitMask = PhysicsCategories.HealthKit;
                break;
            case 3:
                item = SKSpriteNode(imageNamed: "sanity_kit");
                item.lightingBitMask = PhysicsCategories.SanityKit;
                item.physicsBody = SKPhysicsBody(rectangleOfSize: item.size);
                item.physicsBody?.categoryBitMask = PhysicsCategories.SanityKit;
                break;
            default:
                break;
            }
            
            item.physicsBody?.affectedByGravity = false;
            item.physicsBody?.dynamic = false;
            item.position = CGPointMake(pt.x * ProjectConstants.TileWidth, -pt.y * ProjectConstants.TileHeight);
            item.zPosition = 5;
            delegate?.addItemToLevel(item);
            previousCanPositions.append(pt);
            grassTiles.removeAtIndex(grassPt);
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
            grassTiles.removeAtIndex(grassTiles.indexOf(p)!);
        }
    }
    
    private func IsChokePoint(pt:CGPoint) -> Bool {
        let left = pt - CGPointMake(1, 0);
        let right = pt + CGPointMake(1, 0);
        let up = pt + CGPointMake(0, 1);
        let down = pt - CGPointMake(0, 1);
        
        return (isWallLoc(left) && isWallLoc(right) && isGrass(up) && isGrass(down)) || (isWallLoc(up) && isWallLoc(down) && isGrass(left) && isGrass(right));
    }
    
    mutating func spawnEnemies() {
        if let gm = gameManager {
            numberOfEnemies = (gm.prevLevel + 1) * 3;
        }
        for _ in 0..<numberOfEnemies {
            let grassPt = GKGaussianDistribution(forDieWithSideCount: grassTiles.count).nextInt();
            var pt = CGPointZero;
            repeat {
                pt = grassTiles[grassPt];
            } while (!(entrancePosition.distance(pt) >= minDistanceBetweenEnemyAndEntrance));
            
            
            let enemy = Enemy();
            enemy.position = CGPointMake(pt.x * ProjectConstants.TileWidth, -pt.y * ProjectConstants.TileHeight);
            enemy.zPosition = 5;
            delegate?.addEnemyToLevel(enemy);
            grassTiles.removeAtIndex(grassPt);
        }
    }
    
    func isObstructed(point:CGPoint) -> Bool {
        let pt = worldToGrid(point);
        
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && (getTile(position: pt) == tileTypes.wall.rawValue || getTile(position: pt) == tileTypes.table.rawValue);
    }
    func isWall(point:CGPoint) -> Bool {
        
        let pt = worldToGrid(point);
        
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && getTile(position: pt) == tileTypes.wall.rawValue;
    }
    
    private func isWallLoc(pt:CGPoint) -> Bool {
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && getTile(position: pt) == tileTypes.wall.rawValue;
    }
    private func isGrass(pt:CGPoint) -> Bool {
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && getTile(position: pt) == tileTypes.grass.rawValue;
    }
    
    func isExit(point:CGPoint) -> Bool {
        
        let pt = worldToGrid(point);
        
        return pt.x.between(0, max: mapSize.x - 1) && pt.y.between(0, max: mapSize.y - 1) && getTile(position: pt) == tileTypes.levelExit.rawValue;
    }
    
    func presentLayerViaDelegate() {
        for (indexr, row) in tiles.enumerate() {
            for (indexc, cvalue) in row.enumerate() {
                delegate?.createNodeOf(type: tileTypes(rawValue: cvalue)!, location: CGPoint(x:ProjectConstants.TileWidth * CGFloat(indexc), y: ProjectConstants.TileHeight * CGFloat(-indexr)));
            }
        }
    }
    
    //MARK: Convert Between Grid and World
    func worldToGrid(pt:CGPoint) -> CGPoint {
        let ax = CGFloat(floor(pt.x / ProjectConstants.TileWidth));
        let ay = CGFloat(floor(-pt.y / ProjectConstants.TileHeight));
        return CGPoint(x: Int(ax), y:Int(ay));
    }
    
    func gridToWorld(pt:CGPoint) -> CGPoint {
        return CGPointMake(pt.x * ProjectConstants.TileWidth, -pt.y * ProjectConstants.TileHeight);
    }
}