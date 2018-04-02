import SpriteKit

extension GameScene: LevelGeneratorDelegate {

    func didAchieveGoal(location: CGPoint, size: CGSize) -> Bool {

        let gameRect = CGRect(origin: CGPoint.zero, size: CGSize(width: self.size.width, height: self.size.height))

        if !gameRect.contains(ball.position) {
            self.gameOver()
            return false
        }

        let margin: CGFloat = 50
        let marginSize: CGSize = CGSize(width: size.width - margin, height: size.height - margin)
        let half: CGFloat = 0.5
        let normalizedLocation = CGPoint(x: location.x - (half * marginSize.width), y: location.y - (half * marginSize.height))
        let rect = CGRect(origin: normalizedLocation, size: marginSize)

        if rect.contains(ball.position) {
            return true
        }

        if !heartBar.loseHeart() {
            self.gameOver()
        }
        return false
    }

    func addNode(_ node: SKNode) {
        self.addChild(node)
    }

    func getState() -> GameState {
        return self.state
    }
}

