import SpriteKit

extension GameScene {

    public func gameOver() {

        if let timer = self.ballTimer {
            timer.invalidate()
        }

        self.levelGenerator?.stop()

        self.windFlow.removeFromParent()
        self.ball.removeFromParent()
        self.heartBar.remove()
        self.dismissNode(node: self.fan, to: CGPoint(x: self.fan.position.x, y: -200))

        ScoreSystem.shared.updateHighestScore()

        if let generator = self.levelGenerator {
            generator.clean()
        }

        configureGameOver()
    }

    public func configureGameOver() {
        self.state = .gameOver
        configurePoints()
        configureHighestScore()
        configureMenuButton()
        configureRestartButton()
    }

    func configurePoints() {
        let point = CGPoint(x: size.width / 2, y: size.height * 2 / 3)
        let move = SKAction.move(to: point, duration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0)
        let scaleUp = SKAction.scale(by: 1.6, duration: 0.4)

        let group = SKAction.group([move, scaleUp])

        self.scoreLabel.run(group)
    }

    func configureHighestScore() {
        let label = SKLabelNode(text: "Highest: \(ScoreSystem.shared.highestScore)")
        label.position = CGPoint(x: size.width / 2, y: size.height * 7 / 12)
        label.fontSize = 30
        label.fontColor = UIColor.white
        label.fontName = "AvenirNext-DemiBold"

        let hidden = SKAction.fadeAlpha(to: 0, duration: 0)
        label.run(hidden)

        self.highestLabel = label
        self.addChild(label)

        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.4)
        label.run(fadeIn)
    }

    func configureMenuButton() {
        let sprite = SKSpriteNode(imageNamed: "MenuButton")
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 8)
        let sizeConversion = 0.5 * size.width / sprite.size.width
        sprite.size = CGSize(width: sprite.size.width * sizeConversion, height: sprite.size.height * sizeConversion)
        sprite.zPosition = 100000

        sprite.name = MenuNodeKeys.menu.rawValue
        self.menuButton = sprite
        self.addChild(sprite)
    }

    func configureRestartButton() {
        let sprite = SKSpriteNode(imageNamed: "RestartButton")
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 4)
        let sizeConversion = 0.5 * size.width / sprite.size.width
        sprite.size = CGSize(width: sprite.size.width * sizeConversion, height: sprite.size.height * sizeConversion)
        sprite.zPosition = 100000

        sprite.name = MenuNodeKeys.restart.rawValue
        self.restartButton = sprite
        self.addChild(sprite)
    }

}

