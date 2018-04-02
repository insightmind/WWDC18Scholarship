import SpriteKit

extension GameScene {

    public func configureMenu() {
        configureBackground()
        configureLogo()
        configureStartButton()
        configureEasterEgg()
        configureBall()
        configureWind()
    }

    func configureWind() {
        let origin = CGPoint(x: 0.5 * size.width, y: 100)
        let windSize = CGSize(width: 50, height: 0.75 * size.height)
        self.windFlow = Wind(frame: CGRect(origin: origin, size: windSize))
        windFlow.zPosition = -20
        self.addChild(windFlow)
    }

    func configureBall() {
        let startPosition = CGPoint(x: 0.5 * size.width, y: size.height)
        ball.size = CGSize(width: 50, height: 50)
        ball.configure(position: startPosition)
        self.addChild(ball)
    }

    func configureBackground() {
        if let background = self.background {
            background.removeFromParent()
        }
        
        let random = Int(randomNumber(max: 3)) + 1
        let sprite = SKSpriteNode(imageNamed: "Background\(random)" )
        sprite.size = size
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sprite.zPosition = -1000000
        self.addChild(sprite)
    }

    func configureLogo() {
        let sprite = SKSpriteNode(imageNamed: "Logo")
        sprite.position = CGPoint(x: size.width / 2, y: 3 * size.height / 4)
        let sizeConversion = size.width / sprite.size.width
        sprite.size = CGSize(width: sprite.size.width * sizeConversion, height: sprite.size.height * sizeConversion)
        sprite.zPosition = 100000

        self.addChild(sprite)
        self.logo = sprite
    }

    func configureStartButton() {
        let sprite = SKSpriteNode(imageNamed: "StartButton")
        sprite.position = CGPoint(x: 0.5 * size.width, y: 80)
        let sizeConversion = 0.5 * size.width / sprite.size.width
        sprite.size = CGSize(width: sprite.size.width * sizeConversion, height: sprite.size.height * sizeConversion)
        sprite.zPosition = 100000
        sprite.name = MenuNodeKeys.start.rawValue

        self.addChild(sprite)

        self.startButton = sprite
    }

    func configureEasterEgg() {
        let sprite = SKSpriteNode(imageNamed: "EasterEgg")
        sprite.position = CGPoint(x: size.width - 25, y: 25)
        let sizeConversion = 0.25 * size.width / sprite.size.width
        sprite.size = CGSize(width: sprite.size.width * sizeConversion, height: sprite.size.height * sizeConversion)
        sprite.zPosition = 100000
        sprite.name = MenuNodeKeys.easter.rawValue

        let rotate = SKAction.rotate(toAngle: 0.25 * CGFloat.pi, duration: 0)
        sprite.run(rotate)
        self.addChild(sprite)

        self.easterEgg = sprite
    }

    public func showEasterEgg() {

        let message = SKSpriteNode(imageNamed: "EasterEggMessage")
        message.position = CGPoint(x: size.width / 2, y: -200)

        let sizeConversion = 0.5 * size.width / message.size.width

        message.size = CGSize(width: message.size.width * sizeConversion, height: message.size.height * sizeConversion)
        message.zPosition = 100000
        message.name = MenuNodeKeys.easterMessage.rawValue

        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0)
        let point = CGPoint(x: size.width / 2, y: size.height / 2)

        self.addChild(message)
        self.easterMessage = message
        self.state = .easter

        message.run(fadeOut) {
            let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.5)
            let move = SKAction.move(to: point, duration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0)

            let group = SKAction.group([fadeIn, move])
            message.run(group)
        }
    }
}
