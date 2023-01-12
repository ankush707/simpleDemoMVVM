//
//  ViewModel.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import Foundation

class NewPlacesViewModel: NSObject {
    
    private var apiRequest: GenericAPIService!
    
    override init() {
        super.init()
        self.apiRequest = GenericAPIService()
        self.getAPIData()
    }
    
    func getAPIData() {
        let url = "https://api.zippopotam.us/us/33162"
        
        self.apiRequest.genericApiCall(urlStr: url, type: APICallType.GET) { modelData in
            self.placesData = modelData
        }
    }
    
    private(set) var placesData : NewPlacesModel? {
        didSet {
            self.bindNewPlacesViewModelViewModelToController()
        }
    }
    
    var bindNewPlacesViewModelViewModelToController : (() -> ()) = {}
}

