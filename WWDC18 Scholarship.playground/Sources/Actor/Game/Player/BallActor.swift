import SpriteKit

public class BallActor: SKSpriteNode {

    public func configure(position: CGPoint) {
        self.position = position
        self.name = "ball"
        configureBallPhysics()
        wobble()
    }

    func configureBallPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.frame.width / 2)
        physicsBody?.mass = 20
        physicsBody?.categoryBitMask = 1
        physicsBody?.fieldBitMask = 1
    }
    
    func wobble() {
        self.removeAllActions()
        let duration: TimeInterval = 1.5
        let moveUp = SKAction.moveBy(x: 0, y: 50, duration: duration/2)
        moveUp.timingMode = .easeInEaseOut
        let moveDown = SKAction.moveBy(x: 0, y: -50, duration: duration/2)
        moveDown.timingMode = .easeInEaseOut
        let actionGroup = SKAction.sequence([moveDown , moveUp])
        let repeatForEver = SKAction.repeatForever(actionGroup)
        run(repeatForEver)
    }

}
