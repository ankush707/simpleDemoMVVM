//
//  ViewModel.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import Foundation

class PlacesViewModel: NSObject {
    
    private var apiRequest: GenericAPIService!
    
    override init() {
        super.init()
        self.apiRequest = GenericAPIService()
        self.getAPIData()
    }
    
    func getAPIData() {
        let url = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
        
        self.apiRequest.genericApiCall(urlStr: url, type: APICallType.GET) { modelData in
            self.placesData = modelData
        }
    }
    
    private(set) var placesData : PlacesModel? {
        didSet {
            self.bindPlacesViewModelViewModelToController()
        }
    }
    
    var bindPlacesViewModelViewModelToController : (() -> ()) = {}
}

