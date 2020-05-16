//
//  UIViewController + Storuboard.swift
//  MyMusic
//
//  Created by Mihails Kuznecovs on 02/02/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? T {
            return vc
        }
        else {
            fatalError("No Initial View Controller in \(name) storybard")
        }
    }
}
