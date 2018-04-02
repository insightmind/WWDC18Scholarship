//
//  Obstacle.swift
//  WWDC18
//
//  Created by Niklas Bülow on 19.03.18.
//  Copyright © 2018 Niklas Bülow. All rights reserved.
//

import SpriteKit
import SceneKit

class Obstacle: SKNode {

    var gameSize: CGSize = CGSize.zero
    var minimumHoleSize: CGSize = CGSize.zero
    private(set) var size: CGSize = CGSize.zero
    private(set) var spritePosition: CGPoint = CGPoint.zero
    
    var check: ((_: Obstacle) -> ())? = nil
    
    func getHole(difficulty: CGFloat) -> CGRect {
        
        let difficultyMargin: CGFloat = (10 - difficulty) > 0 ? 10 - difficulty : 1
        let size = CGSize(width: minimumHoleSize.width + difficultyMargin, height: minimumHoleSize.height + difficultyMargin)
        
        let margin = size.width / 2
        let shrinkedGameSize = CGSize(width: gameSize.width - margin, height: gameSize.height - margin)
        
        let xPosititon = randomNumber(max: shrinkedGameSize.width) + margin / 2
        let yPosititon = randomNumber(max: shrinkedGameSize.height) + margin / 2
        let position = CGPoint(x: xPosititon, y: yPosititon)
        
        return CGRect(origin: position, size: size)
    }

    override init() {
        super.init()
        self.zPosition = -50
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createObstacle(difficulty: Int = 1) {

        self.name = "Obstacle"

        let difficultyFactor = 1 / (Double(difficulty) * 0.75)

        let obstacleInt = Int(randomNumber(max: 3)) + 1
        
        let sprite = SKSpriteNode(imageNamed: "Obstacle\(obstacleInt)")
        
        let rect = getHole(difficulty: CGFloat(difficulty))
        
        sprite.size = rect.size
        self.size = sprite.size

        sprite.position = rect.origin
        spritePosition = sprite.position

        let startZoom = SKAction.scale(by: pow(2, -3), duration: 0)

        let xStart: CGFloat = randomNumber(max: 1) == 1 ? -100 : 600
        let yStart: CGFloat = randomNumber(max: 200)

        let startMove = SKAction.move(to: CGPoint(x: xStart, y: yStart), duration: 0)

        let startGroup = SKAction.group([startMove, startZoom])
        sprite.run(startGroup)

        let move = SKAction.move(to: spritePosition, duration: 0.5 * difficultyFactor, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0)
        let zoom = SKAction.scale(by: pow(2, 3), duration: 3 * difficultyFactor)
        zoom.timingMode = .linear

        let group = SKAction.group([move])
        let sequence = SKAction.sequence([group, zoom])

        addChild(sprite)

        sprite.run(sequence) {
            let dissolve = SKAction.fadeAlpha(to: 0, duration: 0.5 * difficultyFactor)
            self.check?(self)
            sprite.run(dissolve) {
                sprite.removeFromParent()
            }
        }
    }

}

func randomNumber(max: CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(max)))
}
