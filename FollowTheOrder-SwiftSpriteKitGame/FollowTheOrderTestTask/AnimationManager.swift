//
//  AnimationManager.swift
//  FollowTheOrderTestTask
//
//  Created by DiOS on 14.10.2022.
//

import SpriteKit

enum AnimationType: CaseIterable {
    case scale
    case flip
}

protocol AnimationManagerDelegateProtocol: AnyObject {
    func endAnimation()
}

class AnimationManager {
    private var animationType: AnimationType!
    
    var elements:[Element] = []
    
    weak var delegate: AnimationManagerDelegateProtocol!
    
    func prepareForAnimations() {
        animationType = AnimationType.allCases.randomElement()!
        elements.shuffle()
        startAnimation(0)
    }
    
    private func startAnimation(_ index: Int) {
        let element = elements[index]
        
        switch animationType {
        case .scale: scaleAction(element)
        case .flip: randomCoup(element)
        case .none: return
        }
        
        element.run(.wait(forDuration: 1)) {
            if index < self.elements.count - 1 {
                self.startAnimation(index + 1)
            } else {
                self.delegate.endAnimation()
            }
        }
    }
    
    private func scaleAction(_ node: SKNode) {
        let scaleDecrease = SKAction.scale(to: 0.9, duration: 0.1)
        let scaleIncrease = SKAction.scale(to: 1.2, duration: 0.2)
        let scaleNormal = SKAction.scale(to: 1, duration: 0.1)
        
        let sequenceAction = SKAction.sequence([scaleDecrease, scaleIncrease, scaleNormal])
        
        node.run(sequenceAction)
    }
    
    private func randomCoup(_ node: SKNode) {
        let coupX = SKAction.scaleX(to: -1, duration: 0.2)
        let coupY = SKAction.scaleY(to: -1, duration: 0.2)
        
        if Int.random(in: 0...1) == 0 {
            node.run(coupX)
        } else {
            node.run(coupY)
        }
    }
}
