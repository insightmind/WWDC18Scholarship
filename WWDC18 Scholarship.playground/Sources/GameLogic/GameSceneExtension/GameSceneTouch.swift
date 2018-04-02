import SpriteKit

extension GameScene: SKSceneDelegate {

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }

        switch state {
        case .menu:
            guard let touchedNode = self.nodes(at: location).first else { return }
            menuTouchesBegan(touchedNode: touchedNode)
        case .play:
            gameTouchesBegan(location: location)
        case .easter:
            guard let touchedNode = self.nodes(at: location).first else { return }
            easterTouchesBegan(touchedNode: touchedNode)
        case .gameOver:
            guard let touchedNode = self.nodes(at: location).first else { return }
            gameOverTouchesBegan(touchedNode: touchedNode)
        }
    }

    public func easterTouchesBegan(touchedNode node: SKNode) {

        guard let name = node.name else { return }
        switch name {
        case MenuNodeKeys.easter.rawValue, MenuNodeKeys.easterMessage.rawValue:
            self.state = .menu
            dismissNode(node: easterMessage, to: CGPoint(x: size.width / 2, y: -200))
        case MenuNodeKeys.start.rawValue:
            dismissNode(node: easterMessage, to: CGPoint(x: size.width / 2, y: -200))
            dismissMenu()
            play()
        default:
            break
        }
    }

    public func gameOverTouchesBegan(touchedNode node: SKNode) {
        guard let name = node.name else { return }
        switch name {
        case MenuNodeKeys.menu.rawValue:
            dismissGameOver()
            configure()
        case MenuNodeKeys.restart.rawValue:
            dismissGameOver()
            restart()
        default:
            break
        }
    }

    public func menuTouchesBegan(touchedNode node: SKNode) {
        guard let name = node.name else { return }
        switch name {
        case MenuNodeKeys.easter.rawValue:
            showEasterEgg()
        case MenuNodeKeys.start.rawValue:
            dismissMenu()
            play()
        default:
            break
        }
    }

    public func gameTouchesBegan(location: CGPoint) {
        switch state {
        case .play:
            if location.y < self.size.height / 3 {
                windFlow.startWind()
            }
        default: break
        }
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }

        switch state {
        case .play:
            if location.y < self.size.height / 3  {

                windFlow.position = CGPoint(x: location.x, y: windFlow.position.y)
                fan.position = CGPoint(x: location.x, y: fan.position.y)
                if windFlow.isEnabled {
                    ball.position = CGPoint(x: location.x, y: ball.position.y)
                }
            }
        default: break
        }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch state {
        case .play:
            windFlow.stop()
        default: break
        }
    }
}

