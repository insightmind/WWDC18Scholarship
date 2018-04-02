import SpriteKit

extension SKShapeNode {

    func addShadow() {
        let shadowSize = CGSize(width: 100, height: 50)
        let rect = CGRect(origin: CGPoint.zero, size: shadowSize)
        let shadowShape = SKShapeNode(rect: rect, cornerRadius: frame.size.height/2)
        shadowShape.fillColor = UIColor.black.withAlphaComponent(0.8)
        shadowShape.position = CGPoint(x: 5, y: -5)
        shadowShape.zPosition = -1
        addChild(shadowShape)
    }
}
