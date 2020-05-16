//
//  CMTime + Extension.swift
//  MyMusic
//
//  Created by Mihails Kuznecovs on 03/02/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import Foundation
import AVKit


extension CMTime {
    
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSecond = Int(CMTimeGetSeconds(self))
        let seconds = totalSecond % 60
        let minutes = totalSecond / 60
        let timeForatString = String(format: "%02d:%02d", minutes, seconds)
        return timeForatString
    }
}
