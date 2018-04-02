import SpriteKit

extension GameScene {
    public func dismissNode(node: SKNode,to point: CGPoint) {
        let move = SKAction.move(to: point, duration: 0.3)
        node.run(move) {
            node.removeFromParent()
        }
    }

    public func fadeOut(node: SKNode) {
        let fade = SKAction.fadeAlpha(to: 0, duration: 0.3)

        node.run(fade) {
            node.removeFromParent()
        }
    }

    public func dismissMenu() {
        dismissNode(node: logo, to: CGPoint(x: logo.position.x, y: size.height + 400))
        fadeOut(node: startButton)
        fadeOut(node: easterEgg)
    }

    public func dismissGameOver() {
        ScoreSystem.shared.resetCurrentScore()

        self.fadeOut(node: self.menuButton)
        self.fadeOut(node: self.restartButton)
        self.fadeOut(node: self.highestLabel)

        let point = CGPoint(x: self.scoreLabel.position.x, y: size.height + 200)
        self.dismissNode(node: self.scoreLabel, to: point)
    }
}
