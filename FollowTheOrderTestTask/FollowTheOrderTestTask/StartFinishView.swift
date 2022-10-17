//
//  StartFinishView.swift
//  FollowTheOrderTestTask
//
//  Created by DiOS on 14.10.2022.
//

import UIKit

protocol StartFinishViewDelegateProtocol: AnyObject {
    func endInputAnimation()
}

class StartFinishView: UIView {
    
    let startButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Start", for: .normal)
        obj.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        obj.setTitleColor(UIColor.darkGray, for: .normal)
        return obj
    }()
    
    weak var delegate: StartFinishViewDelegateProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tag = 1
        backgroundColor = .systemRed
        alpha = 0
        addSubview(startButton)
        startButton.frame.size = CGSize(width: 100, height: 200)
        startButton.center = center
        inputView()
    }
    
    private func inputView() {
        UIView.animate(withDuration: 0.6) {
            self.alpha = 1
        } completion: { _ in
            self.delegate.endInputAnimation()
        }
    }
    
    func outputView() {
        UIView.animate(withDuration: 0.6) {
            self.alpha = 0
        } completion: { _ in
            self.startButton.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    deinit {
        print("❌deinit \(self)")
    }
}

