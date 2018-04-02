//
//  Scoresystem.swift
//  WWDC18
//
//  Created by Niklas Bülow on 21.03.18.
//  Copyright © 2018 Niklas Bülow. All rights reserved.
//

import SpriteKit

class ScoreSystem {

    static let shared = ScoreSystem()

    weak var label: SKLabelNode?

    private(set) var currentScore: Int = 0
    private(set) var highestScore: Int = 0

    func increaseScore(by score: Int = 1) {
        self.currentScore += score

        label?.text = String(currentScore)
    }

    func resetCurrentScore() {
        self.currentScore = 0

        label?.text = "0"
    }

    func updateHighestScore() {
        guard currentScore >= highestScore else { return }
        highestScore = currentScore
    }
}
