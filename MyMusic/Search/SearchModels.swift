//
//  SearchModels.swift
//  MyMusic
//
//  Created by Mihails Kuznecovs on 02/02/2020.
//  Copyright (c) 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit
import SwiftUI

enum Search {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getTracks(searchTerm: String)
      }
    }
    struct Response {
      enum ResponseType {
        case presentTracks(searchResponse: SearchResponse?)
        case presentFooterView
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayTracks(searchViewModel: SearchViewModel)
        case displayFooterView
      }
    }
  }
  
}


class SearchViewModel: NSObject, NSCoding {
    let cells: [Cell]
    @objc(_TtCC7MyMusic15SearchViewModel4Cell)class Cell: /*TrackCellViewModel*/NSObject, NSCoding, Identifiable {
        var id = UUID()
        var iconUrlString: String?
        var trackName: String
        var collectionName: String
        var artistName: String
        var previewUrl: String?
        
        init(iconUrlString: String?, trackName: String, collectionName: String, artistName: String, previewUrl: String?) {
            self.iconUrlString = iconUrlString
            self.trackName = trackName
            self.collectionName = collectionName
            self.artistName = artistName
            self.previewUrl = previewUrl
        }
        
        func encode(with coder: NSCoder) {
            coder.encode(iconUrlString, forKey: "iconUrlString")
            coder.encode(trackName, forKey: "trackName")
            coder.encode(collectionName, forKey: "collectionName")
            coder.encode(artistName, forKey: "artistName")
            coder.encode(previewUrl, forKey: "previewUrl")
        }
        
        required init?(coder: NSCoder) {
            iconUrlString = coder.decodeObject(forKey: "iconUrlString") as? String? ?? ""
            trackName = coder.decodeObject(forKey: "trackName") as? String ?? ""
            collectionName = coder.decodeObject(forKey: "collectionName") as? String ?? ""
            artistName = coder.decodeObject(forKey: "artistName") as? String ?? ""
            previewUrl = coder.decodeObject(forKey: "previewUrl") as? String? ?? ""
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(cells, forKey: "cells")
    }
    
    required init?(coder: NSCoder) {
        cells = coder.decodeObject(forKey: "cells") as? [SearchViewModel.Cell] ?? []
    }
    
    init(cells: [Cell]) {
        self.cells = cells
    }
}
