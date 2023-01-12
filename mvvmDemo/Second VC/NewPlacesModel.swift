//
//  Model.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import Foundation

// MARK: - NewPlacesModel
struct NewPlacesModel: Codable {
    let postCode, country, countryAbbreviation: String?
    let places: [Place]?

    enum CodingKeys: String, CodingKey {
        case postCode = "post code"
        case country
        case countryAbbreviation = "country abbreviation"
        case places
    }
}

// MARK: - Place
struct Place: Codable {
    let placeName, longitude, state, stateAbbreviation: String?
    let latitude: String?

    enum CodingKeys: String, CodingKey {
        case placeName = "place name"
        case longitude, state
        case stateAbbreviation = "state abbreviation"
        case latitude
    }
}
