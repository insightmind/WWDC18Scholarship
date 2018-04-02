//: ### Playground - noun: a place where people can play
/*:
 Taking this line serious, I wanted to create a game that is easy to play but is not that easy to master.
 Playground is a place to play with ideas and code, so for why should your code not enable you to play even more?
 */
//:---
//: ## Welcome to
//: # FLOATING POINT
//:---
//: ### The goal:
/*:
To put it simple:
 Get the highest score!
 
  - Your score increases if the ball fits inside a ring, traingle or rectangle, when it has reach its size.
 
  - If your ball falls out of the screen, you will be instantly game over.
 
  - If your ball does not fit inside a ring, triangle or rectangle, you will lose one of your three lives.
  - If you remaining lives are at zero, you will be game over.
  */
//: ### How to play:
/*:
    1. Tap start to start
 
    2. Tap on the lower third of the screen to change the fans and so for the x-position of the ball
 
    3. If you tap in the lower third of the screen, the fan will also being activate causing the ball increase its y-position.
 */
/*:
 ---
 ## I highly recommend to run this playground in Xcode 9.3, as it was not tested on Swift Playgrounds for iPad!

 You may need to recompile the playground if it cannot find the sources.

 Crashes are caused by Xcode. Please reopen if Xcode crashes.
 
 You also might need to change the size of the screen below, depending on the device you use. This should not break the playground.
 */
//: ---
//: ### Third party open source repositories:
/*:
 This playground was created using the SpriteKit-Spring repository.
 https://github.com/ataugeron/SpriteKit-Spring
 
 This allowed me to animate with a UIView like animation with a spring effect.
 */
////////////////////////////////////////////////////////////////////////////////////////////////////
//  Copyright 2014 Alexis Taugeron
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////

import PlaygroundSupport
import SpriteKit

let debugMode = true

let size = CGSize(width: 250 * 1.4, height: 425 * 1.4)
let frame = CGRect(origin: CGPoint.zero, size: size)

let gameView = SKView(frame: frame)

gameView.showsFPS = debugMode
gameView.showsPhysics = debugMode
gameView.showsFields = debugMode
gameView.showsDrawCount = debugMode
gameView.showsNodeCount = debugMode
gameView.showsQuadCount = debugMode

let scene = GameScene(size: size)

gameView.presentScene(scene)

PlaygroundPage.current.liveView = gameView
