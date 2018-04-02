import SpriteKit

public class HeartBar: SKNode {

    private var hearts: [Heart] = []

    public init(rect: CGRect, numberOfHearts: Int) {
        super.init()

        let size = rect.size
        self.position = rect.origin
        let widthPerHeart = rect.size.width / CGFloat(numberOfHearts) - 10

        for index in 0..<numberOfHearts {
            let position = CGPoint(x: CGFloat(index) * (widthPerHeart + 10), y: -rect.origin.y)
            let heart = Heart(rect: CGRect(origin: position, size: CGSize(width: widthPerHeart, height: size.height)))
            heart.position = position
            hearts.append(heart)
            self.addChild(heart)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loseHeart() -> Bool {
        guard let heart = hearts.last else { return false }
        heart.remove()
        hearts.removeLast(1)

        if hearts.isEmpty { return false }
        return true
    }

    func remove() {
        let scale = SKAction.scale(to: 0, duration: 0.2)
        scale.timingMode = .easeIn

        self.run(scale) {
            self.removeFromParent()
        }
    }

}

