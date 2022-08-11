//
//  countryModels.swift
//  21(misho zirakashvili)
//
//  Created by misho zirakashvili on 11.08.22.
//

import Foundation

struct Country: Decodable {
    let name: String
    let capital: String?
    let flagURL: Flags
    let regionalBlocs: [RegionalBloc]?
    
    enum CodingKeys: String, CodingKey {
        case name, capital, regionalBlocs
        case flagURL = "flags"
    }
}
struct RegionalBloc: Decodable {
    let acronym: String
    let name: String
}

struct Flags: Decodable {
    let png: String
}
