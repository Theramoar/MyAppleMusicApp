//
//  Nib.swift
//  MyMusic
//
//  Created by Mihails Kuznecovs on 05/02/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as! T
    }
}
