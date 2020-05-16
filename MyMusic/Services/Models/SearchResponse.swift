//
//  SearchResponse.swift
//  MyMusic
//
//  Created by Mihails Kuznecovs on 02/02/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import Foundation


struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
    var previewUrl: String?
}
