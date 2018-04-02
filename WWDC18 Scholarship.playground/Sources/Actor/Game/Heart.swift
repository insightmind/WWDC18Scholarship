import SpriteKit

class Heart: SKSpriteNode {
    convenience init(rect: CGRect) {
        self.init(imageNamed: "Heart")
        self.size = rect.size
        self.position = rect.origin
        self.zPosition = 100000

        self.pulsate()
    }

    func pulsate() {
        let scaleUp = SKAction.scale(by: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(by: 1.0 / 1.1, duration: 0.5)

        let sequence = SKAction.sequence([scaleUp, scaleDown])
        let forEver = SKAction.repeatForever(sequence)

        self.run(forEver)
    }

    func remove() {

        let scale = SKAction.scale(to: 0, duration: 0.2)
        scale.timingMode = .easeIn

        self.run(scale) {
            self.removeFromParent()
        }
    }
}
