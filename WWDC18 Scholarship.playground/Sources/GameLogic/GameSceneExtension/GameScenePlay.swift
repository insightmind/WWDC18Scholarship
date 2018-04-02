import SpriteKit

extension GameScene {

    public func play() {
        self.state = .play
        configureGame()

        self.ballTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if self.ball.position.y < 40 {
                timer.invalidate()
                self.gameOver()
            }
        }
    }

    public func restart() {
        play()
        configureBall()
        configureWind()
        configureBackground()
    }

    public func configureGame() {
        configureRotor()
        configureLevelGenerator()
        configureHearts()
        configureScore()
    }

    func configureRotor() {
        let rotor = SKSpriteNode(imageNamed: "fan")
        rotor.position = CGPoint(x: 0.5 * size.width, y: 80)
        rotor.zPosition = -10
        rotor.size = CGSize(width: 90, height: 90)
        rotor.name = "fan"
        self.fan = rotor
        self.addChild(rotor)
    }

    func configureLevelGenerator() {

        let gameSize = CGSize(width: size.width - 40, height: size.height * 2 / 3)
        let positionOffset = CGPoint(x: 20, y: size.height / 4)
        let minimumHoleSize = CGSize(width: 200, height: 200)
        let levelGenerator = LevelGenerator(gameSize: CGRect(origin: positionOffset, size: gameSize), ballSize: minimumHoleSize)
        self.levelGenerator = levelGenerator
        levelGenerator.delegate = self
        levelGenerator.start()
    }

    func configureScore() {
        let name = SKLabelNode(text: "0")
        name.fontSize = 40
        name.fontColor = UIColor.white
        name.fontName = "AvenirNext-Bold"
        name.position = CGPoint(x: size.width - 50, y: size.height - 50)
        name.zPosition = 20000
        ScoreSystem.shared.label = name
        self.scoreLabel = name
        self.addChild(name)
    }

    func configureHearts() {
        let rect = CGRect(x: 0, y: 0, width: size.width * 0.4, height: 35)
        let bar = HeartBar(rect: rect, numberOfHearts: 3)
        bar.position = CGPoint(x: 30, y: size.height - 35)
        bar.zPosition = 100000
        self.heartBar = bar
        self.addChild(bar)
    }
}
