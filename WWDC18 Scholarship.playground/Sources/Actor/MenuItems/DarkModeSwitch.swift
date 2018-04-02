//
//  DarkModeSwitch.swift
//  WWDC18
//
//  Created by Niklas Bülow on 19.03.18.
//  Copyright © 2018 Niklas Bülow. All rights reserved.
//

import SpriteKit

protocol DarkModeSwitchDelegate: AnyObject {
    func setDark()
    func setLight()
}

class DarkModeSwitch: SKNode {

    private let shape: SKShapeNode
    private let stateShape: SKShapeNode

    weak var delegate: DarkModeSwitchDelegate?

    private(set) var state: Bool = false

    init(frame: CGRect, state: Bool) {
        shape = SKShapeNode(rect: frame, cornerRadius: frame.height/2)
        shape.fillColor = UIColor.clear
        shape.lineWidth = 2

        stateShape = SKShapeNode(circleOfRadius: frame.height / 2 - 10)
        stateShape.strokeColor = .clear
        stateShape.lineWidth = 0

        super.init()

        self.position = frame.origin

        self.addChild(shape)
        self.addChild(stateShape)

        self.state = !state
        toggle(animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func toggle(animated: Bool) {

        self.state = !state

        if state {
            shape.strokeColor = UIColor.black
        } else {
            shape.strokeColor = UIColor.white
        }
    }

    private func setDark(animated: Bool) {
        if let delegate = self.delegate {
            delegate.setDark()
        }

        let position = CGPoint(x: frame.width - 10, y: frame.height / 2)
        let duration = animated ? 0.5 : 0
        let color = SKAction.colorize(with: .purple, colorBlendFactor: 1.0, duration: duration)
        let move = SKAction.move(to: position, duration: duration)
        let group = SKAction.group([color, move])

        stateShape.run(group)

        shape.strokeColor = .white
    }

    private func setLight(animated: Bool) {
        if let delegate = self.delegate {
            delegate.setLight()
        }

        let position = CGPoint(x: 10, y: frame.height / 2)

        let duration = animated ? 0.5 : 0
        let color = SKAction.colorize(with: .purple, colorBlendFactor: 1.0, duration: duration)
        let move = SKAction.move(to: position, duration: duration)
        let group = SKAction.group([color, move])

        stateShape.run(group)

        shape.strokeColor = .black
    }

}
