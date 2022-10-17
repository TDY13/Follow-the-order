//
//  GameScene.swift
//  FollowTheOrderTestTask
//
//  Created by DiOS on 14.10.2022.
//

import SpriteKit

protocol GameSceneDelegateProtocol: AnyObject {
    func reloadScene()
}

class GameScene: SKScene {
    let animationManager = AnimationManager()
    
    var tapedNodes: [Element] = []
    
    weak var myDelegate: GameSceneDelegateProtocol!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        createLabelWithPrompt()
        backgroundColor = .systemRed
        animationManager.delegate = self
        elementsCreate()
    }
    
    private func elementsCreate() {
        let countElements = UserDefaultsManager.shared.lvlNumber + 5
        var positions = GridManager.createArrayPositions()
        for _ in 0 ..< countElements {
            let element = Element.init()
            element.delegate = self
            let elementIndex = Int.random(in: 0 ..< positions.count)
            let position = positions.remove(at: elementIndex)
            element.position = position
            self.addChild(element)
        }
        self.run(.wait(forDuration: 2)) {
            var arrayOfNodes: [Element] = []
            self.enumerateChildNodes(withName: "Element") { node, stop in
                if node is Element {
                    arrayOfNodes.append(node as! Element)
                }
            }
            self.animationManager.elements = arrayOfNodes
            self.animationManager.prepareForAnimations()
        }
    }
    
    private func checkTapedNodes() {
        for i in 0 ..< animationManager.elements.count {
            let animateElement = animationManager.elements[i]
            let tapElement = tapedNodes[i]
            
            if animateElement !== tapElement {
                gameOver()
                return
            }
        }
        success()
    }
    
    func deleteSelf() {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        myDelegate.reloadScene()
    }
    
    func createLabelWithPrompt() {
        let helpLabel = SKLabelNode()
        helpLabel.fontColor = .systemGray5
        helpLabel.text = "Tap on the screen\nto close"
        helpLabel.numberOfLines = 2
        helpLabel.fontSize = 55
        helpLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        helpLabel.horizontalAlignmentMode = .center
        helpLabel.verticalAlignmentMode = .center
        addChild(helpLabel)
    }
    
    deinit {
        print("deinit Scene")
    }
}

extension GameScene: ElementDelegateProtocol {
    func correctTap(_ element: Element) {
        tapedNodes.append(element)
        let countElements = UserDefaultsManager.shared.lvlNumber + 5
        if tapedNodes.count == countElements {
            checkTapedNodes()
        }
    }
    
    func incorrectTap() {
        gameOver()
    }
}

extension GameScene: AnimationManagerDelegateProtocol {
    func endAnimation() {
        self.enumerateChildNodes(withName: "Element") { node, stop in
            if node is Element {
                (node as! Element).isUserInteractionEnabled = true
            }
        }
    }
}

extension GameScene {
    func gameOver() {
        print("❌Game Over❌")
        self.enumerateChildNodes(withName: "Element") { node, stop in
            if node is Element {
                (node as! Element).addParticles()
            }
        }
        UserDefaultsManager.shared.lvlNumber -= 1 
        self.run(.wait(forDuration: 3)) {
            self.myDelegate.reloadScene()
        }
    }
}

extension GameScene {
    func success() {
        print("✅")
        UserDefaultsManager.shared.lvlNumber += 1
        myDelegate.reloadScene()
        Service.shared.wishRequest()
    }
}
