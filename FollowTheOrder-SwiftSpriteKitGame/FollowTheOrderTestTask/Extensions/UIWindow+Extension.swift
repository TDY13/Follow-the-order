//
//  UIWindow+Extension.swift
//  FollowTheOrderTestTask
//
//  Created by DiOS on 14.10.2022.
//

import UIKit

extension UIWindow {
    
    class func getWindow() -> UIWindow? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as! UIWindowScene
        let window = windowScene.windows.first
        return window
    }
}
