//
//  Breed.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 09-08-21.
//

import Foundation

typealias Breed = String

// MARK: - Breed
struct BreedCollection: Codable {
    let breeds: [Breed]?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case breeds = "message"
        case status
    }
}
