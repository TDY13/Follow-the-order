//
//  GridManager.swift
//  FollowTheOrderTestTask
//
//  Created by DiOS on 14.10.2022.
//

import UIKit

class GridManager {
    
    class func createArrayPositions() -> [CGPoint] {
        let amountCellsX = Int(UIScreen.main.bounds.width / Element.elementSize)
        guard let window = UIWindow.getWindow() else { fatalError() }
        let heightScene = UIScreen.main.bounds.height -  window.safeAreaLayoutGuide.layoutFrame.origin.y 
        let amountCellsY = Int(heightScene / Element.elementSize)
        let heightCell = heightScene / CGFloat(amountCellsY)
        
        var positionsArray: [CGPoint] = []
        
        for x in 0 ..< amountCellsX {
            let posX = Element.elementSize / 2 + Element.elementSize * CGFloat(x)
            for y in 0 ..< amountCellsY {
                let posY = heightCell / 2 + heightCell * CGFloat(y)
                let point = CGPoint(x: posX, y: posY)
                positionsArray.append(point)
            }
        }
        return positionsArray
    }
}
