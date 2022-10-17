//
//  ViewController.swift
//  FollowTheOrderTestTask
//
//  Created by DiOS on 14.10.2022.
//

import SpriteKit

class ViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        view = SKView(frame: view.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        createStartFinishView()
        showStatistics()
    }
    
    private func createStartFinishView() {
        let mainView = StartFinishView(frame: view.bounds)
        mainView.startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        view.addSubview(mainView)
        mainView.delegate = self
    }
    
    private func createScene() {
        let gameScene = GameScene(size: view.frame.size)
        (view as! SKView).presentScene(gameScene)
        gameScene.myDelegate = self
    }

    private func showStatistics() {
        (view as! SKView).showsFPS = true
        (view as! SKView).showsFields = true
        (view as! SKView).showsPhysics = true
        (view as! SKView).showsNodeCount = true
    }
}
//MARK: - StartStopView Delegate
extension ViewController: StartFinishViewDelegateProtocol {
    func endInputAnimation() {
        if (view as! SKView).scene != nil {
            ((view as! SKView).scene as! GameScene).deleteSelf()
            (view as! SKView).presentScene(nil)
        }
        createScene()

    }
}
//MARK: - GameSceneDelegate
extension ViewController: GameSceneDelegateProtocol {
    func reloadScene() {
        createStartFinishView()
    }
}
//MARK: - Add target
extension ViewController {
    @objc private func didTapStartButton() {
        let mainView = view.viewWithTag(1) as! StartFinishView
        mainView.outputView()
    }
}
