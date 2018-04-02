//
//  LevelGenerator.swift
//  WWDC18
//
//  Created by Niklas Bülow on 19.03.18.
//  Copyright © 2018 Niklas Bülow. All rights reserved.
//

import SpriteKit

protocol LevelGeneratorDelegate: AnyObject {
    func addNode(_ node: SKNode)
    func didAchieveGoal(location: CGPoint, size: CGSize) -> Bool
    func getState() -> GameState
}

public class LevelGenerator {

    weak var delegate: LevelGeneratorDelegate?

    private var gameSize: CGRect = CGRect.zero
    private var obstacles: [Obstacle] = []
    private var ballSize: CGSize = CGSize.zero

    private var timePerRound: TimeInterval = 5
    private var difficulty: Int = 1

    private let zoomFactorPerRound: CGFloat = 2
    private let numOfObstacles: Int = 3
    
    private lazy var zoom: SKAction = {
        return SKAction.scale(by: zoomFactorPerRound, duration: timePerRound)
    }()
    
    private lazy var dissolve: SKAction = {
        return SKAction.fadeAlpha(to: 0, duration: timePerRound)
    }()
    
    private lazy var fadeIn: SKAction = {
        return SKAction.fadeAlpha(to: 1, duration: timePerRound)
    }()
    
    private var timer: Timer = Timer()

    init(gameSize: CGRect, ballSize: CGSize) {
        self.gameSize = gameSize
        self.ballSize = ballSize
        setup()
    }
    
    func setup() {
        
    }

    func next() {
        guard let delegate = self.delegate else { return }

        let obstacle = generateObstacle()

        self.obstacles.append(obstacle)
        delegate.addNode(obstacle)
    }
    
    func animate() {
        for (index, obstacle) in obstacles.enumerated() {
            if index == obstacles.count - 1 {
                let group = SKAction.group([fadeIn, zoom])
                obstacle.run(group)
                continue
            }
            
            obstacle.run(zoom)
        }
    }
    
    func generateObstacle() -> Obstacle {
        let obstacle = Obstacle()
        obstacle.gameSize = gameSize.size
        obstacle.minimumHoleSize = ballSize
        obstacle.createObstacle(difficulty: difficulty)
        obstacle.position = CGPoint(x: obstacle.position.x + gameSize.origin.x, y: obstacle.position.y + gameSize.origin.y)
        obstacle.check = check
        return obstacle
    }

    func check(obstacle: Obstacle) {

        if let delegate = self.delegate {
            if delegate.getState() != .play {
                clean()
                return
            }

            let position = CGPoint(x: gameSize.origin.x + obstacle.spritePosition.x, y: gameSize.origin.y + obstacle.spritePosition.y)
            if delegate.didAchieveGoal(location: position, size: obstacle.size) {
                ScoreSystem.shared.increaseScore()
            }
        }

        if (ScoreSystem.shared.currentScore + 1) % (3 * difficulty) == 0  && ScoreSystem.shared.currentScore <= 500 {
            alterDifficultyLevel(to: (ScoreSystem.shared.currentScore + 1) / (3 * difficulty) + 1)
        }

        for (index, node) in obstacles.enumerated() {
            if obstacle == node {
                obstacle.removeAllActions()
                obstacles.remove(at: index)
                break
            }
        }
    }
    
    func stop() {
        self.timer.invalidate()
    }
    
    func clean() {
        for obstacle in obstacles {
            obstacle.removeAllActions()
            obstacle.removeFromParent()
        }
        obstacles.removeAll()
    }
    
    func alterDifficultyLevel(to value: Int) {
        if difficulty == value { return }
        self.difficulty = value
        stop()

        let newDifficulty = SKLabelNode(text: "Difficulty: " + String(difficulty))
        newDifficulty.fontSize = 40
        newDifficulty.fontName = "AvenirNext-DemiBold"
        newDifficulty.position = CGPoint(x: gameSize.size.width / 2 + gameSize.origin.x, y: gameSize.size.height / 2 + gameSize.origin.y)

        delegate?.addNode(newDifficulty)

        let textAppear = SKAction.scale(by: 1.3, duration: 1)
        let textFadeIn = SKAction.fadeAlpha(to: 1, duration: 1)
        let group = SKAction.group([textAppear,textFadeIn])

        let textDissolve = SKAction.fadeAlpha(to: 0, duration: 1)
        let sequence = SKAction.sequence([group])

        newDifficulty.run(sequence) {
            self.start()
            newDifficulty.run(textDissolve)
        }
    }
    
    func start() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 4 * (1 / (Double(difficulty) * 0.75)), repeats: true) { (timer) in
            self.next()
        }
    }
}
