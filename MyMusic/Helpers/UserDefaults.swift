//
//  UserDefaults.swift
//  MyMusic
//
//  Created by Mihails Kuznecovs on 10/02/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let favouriteTrackKey = "favouriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        guard let savedTracks = UserDefaults.standard.object(forKey: UserDefaults.favouriteTrackKey) as? Data else { return [] }
        guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as? [SearchViewModel.Cell] else { return [] }
        
        return decodedTracks
    }
}
