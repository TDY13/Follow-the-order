//
//  Element.swift
//  FollowTheOrderTestTask
//
//  Created by DiOS on 14.10.2022.
//

import SpriteKit

protocol ElementDelegateProtocol: AnyObject {
    func correctTap(_ element: Element)
    func incorrectTap()
}
                                        
class Element: SKShapeNode {
    var isTap = false
    weak var delegate: ElementDelegateProtocol!
    
    static let elementSize = UIScreen.main.bounds.width * 0.2
    
    override init() {
        super.init()
        setup()
        self.name = "Element"
        self.isUserInteractionEnabled = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let ovalRect = CGRect(x: -Element.elementSize / 2, y: -Element.elementSize / 2, width: Element.elementSize, height: Element.elementSize)
        let myPath = UIBezierPath(ovalIn: ovalRect)
        path = myPath.cgPath
        fillColor = .cyan
        strokeColor = .white
    }
    
    func addParticles() {
        fillColor = .clear
        strokeColor = .clear
        let emitterNode = SKEmitterNode()
        emitterNode.position = self.position
        emitterNode.particleTexture = createParticlesTexture()
        emitterNode.particlePositionRange = CGVector(dx: Element.elementSize, dy: Element.elementSize)
        emitterNode.particleBirthRate = 3000
        emitterNode.numParticlesToEmit = 500
        emitterNode.particleLifetime = 1.5
        emitterNode.particleLifetimeRange = 0.5
        emitterNode.particleSpeed = 40
        emitterNode.particleSpeedRange = 70
        emitterNode.emissionAngleRange = .pi * 2
        emitterNode.particleScaleSpeed = -0.1
        scene?.addChild(emitterNode)
        self.run(.wait(forDuration: 3)) {
            emitterNode.removeFromParent()
        }
    }
    
    private func createParticlesTexture() -> SKTexture {
        let sprt = SKSpriteNode(color: .cyan, size: CGSize(width: 5.0, height: 5.0))
        let skView = SKView()
        let texture = skView.texture(from: sprt)
        return texture!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTap == false {
            isTap.toggle()
            delegate.correctTap(self)
        } else {
            delegate.incorrectTap()
        }
        scaleAction()
    }
    
    private func scaleAction() {
        let scaleDecrease = SKAction.scale(to: 0.9, duration: 0.1)
        let scaleIncrease = SKAction.scale(to: 1.2, duration: 0.1)
        let scaleNormal = SKAction.scale(to: 1, duration: 0.1)
        
        let sequenceAction = SKAction.sequence([scaleDecrease, scaleIncrease, scaleNormal])
        
        self.run(sequenceAction)
    }
}
