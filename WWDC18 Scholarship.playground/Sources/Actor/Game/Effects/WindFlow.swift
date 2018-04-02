
import SpriteKit

public class Wind: SKNode {

    private let numOfWindNodes = 5
    private let durationPerNode: TimeInterval = 1.3
    private let windSize: CGSize

    private var windNodes = [SKSpriteNode]()
    private var flowEmitter: SKEmitterNode?

    private var timer: Timer = Timer()

    private var field: SKFieldNode?

    var isEnabled: Bool = false

    init(frame: CGRect) {
        self.windSize = frame.size
        super.init()
        self.position = frame.origin
        configurePhysics()

        startWind()
    }

    func startWind() {

        if isEnabled { return }
        else { isEnabled = true }

        let duration = durationPerNode / TimeInterval(numOfWindNodes)

        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: true, block: { (timer) in
            if self.windNodes.count >= self.numOfWindNodes {
                timer.invalidate()
            } else {
                self.addWindNode()
            }
        })

        addWindFlowNode()

        guard let field = self.field else { return }
        field.isEnabled = true
    }

    func start(node: SKSpriteNode, duration: TimeInterval) {

        let move = SKAction.moveTo(y: windSize.height, duration: duration)
        let moveToOrigin = SKAction.moveTo(y: 0, duration: 0)
        let moveSequence = SKAction.sequence([move, moveToOrigin])

        let repeatMove = SKAction.repeatForever(moveSequence)

        let startDissolve = SKAction.fadeAlpha(to: 1, duration: duration * 0.1)
        let dissolve = SKAction.fadeAlpha(to: 0, duration: duration * 0.2)
        let endDissolve = SKAction.wait(forDuration: duration * 0.7)
        let dissolveSequence = SKAction.sequence([startDissolve,endDissolve,dissolve])
        let repeatDissolve = SKAction.repeatForever(dissolveSequence)
        let group = SKAction.group([repeatDissolve,repeatMove])

        node.run(group)
    }

    func addWindNode() {

        let node = SKSpriteNode(imageNamed: "WindNode")
        node.position = CGPoint(x: 0, y: 0)
        node.size = CGSize(width: 60, height: 40)
        node.zPosition = 3

        start(node: node, duration: durationPerNode)

        windNodes.append(node)

        addChild(node)
    }

    func addWindFlowNode() {

        guard let windEmitter = SKEmitterNode(fileNamed: "IVY") else { return }
        windEmitter.position = CGPoint(x: 0, y: 25)
        addChild(windEmitter)
        flowEmitter = windEmitter

    }

    func stop() {

        if !isEnabled { return }
        else { isEnabled = false }

        timer.invalidate()

        for node in windNodes {
            node.removeFromParent()
        }

        windNodes.removeAll()

        if let flowEmitter = self.flowEmitter {
            flowEmitter.removeFromParent()
        }

        guard let field = self.field else { return }
        field.isEnabled = false


    }

    func configurePhysics() {
        let vector = float3([0, 1, 0])
        let velocityField = SKFieldNode.velocityField(withVector: vector)
        self.field = velocityField
        let fieldSize = CGSize(width: 2 * windSize.width, height: 2 * windSize.height)
        velocityField.region = SKRegion(size: fieldSize)
        velocityField.strength = 0.1
        velocityField.smoothness = 1
        velocityField.falloff = 50
        velocityField.categoryBitMask = 1
        self.addChild(velocityField)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
