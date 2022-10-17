//
//  Service.swift
//  FollowTheOrderTestTask
//
//  Created by DiOS on 16.10.2022.
//

import Foundation

class Service {
    static let shared = Service()
    
    private init() {
    }
    
    typealias BestWish = (String) -> Void
    
    func wishRequest() {
        let url = URL(string: "http://yerkee.com/api/fortune")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                let str = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments)
                print(str)
            } catch {
                print("json error: \(error)")
            }
            
        }
        task.resume()
    }
    
}
