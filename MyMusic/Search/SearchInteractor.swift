//
//  SearchInteractor.swift
//  MyMusic
//
//  Created by Mihails Kuznecovs on 02/02/2020.
//  Copyright (c) 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
  func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var networkService = NetworkService()
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {
        case .getTracks(let searchTerm):
            self.presenter?.presentData(response: .presentFooterView)
            networkService.fetchTracks(searchText: searchTerm) { [weak self] (searchResponse) in
                self?.presenter?.presentData(response: .presentTracks(searchResponse: searchResponse))
            }
        }
    }    
}
