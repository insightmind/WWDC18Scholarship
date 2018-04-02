import SpriteKit

public enum MenuNodeKeys: String {
    case easter
    case easterMessage
    case start
    case restart
    case menu
}

public class GameScene: SKScene {

    public var windFlow: Wind = Wind(frame: CGRect.zero)
    public var fan: SKSpriteNode = SKSpriteNode()
    public var ball: BallActor = BallActor(imageNamed: "ball")
    public var scoreLabel: SKLabelNode = SKLabelNode()
    public var heartBar: HeartBar = HeartBar(rect: CGRect.zero, numberOfHearts: 0)
    public var levelGenerator: LevelGenerator?

    public var background: SKSpriteNode?

    public var easterEgg: SKSpriteNode = SKSpriteNode()
    public var startButton: SKSpriteNode = SKSpriteNode()
    public var logo: SKSpriteNode = SKSpriteNode()

    public var easterMessage: SKSpriteNode = SKSpriteNode()

    public var highestLabel: SKLabelNode = SKLabelNode()
    public var menuButton: SKSpriteNode = SKSpriteNode()
    public var restartButton: SKSpriteNode = SKSpriteNode()

    public var state: GameState = GameState.menu

    public var ballTimer: Timer?

    public override init(size: CGSize) {
        super.init(size: size)
        configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        configureMenu()
        state = .menu
    }
}


