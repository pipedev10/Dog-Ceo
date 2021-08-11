//
//  AlamofireServices.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 09-08-21.
//

import Foundation
import Alamofire

protocol BreedService {
    func getListBreeds(completion: @escaping (Result<[Breed], Error>) -> Void)
    func getListImagesByBreed(by name: String, completion: @escaping (Result<[Breed], Error>) -> Void)
}

final class BreedServiceImpl: BreedService {
    func getListBreeds(completion: @escaping (Result<[Breed], Error>) -> Void) {
        AF.request("\(AppConstants.URL_DOG_CEO)/breeds/list").responseDecodable(of: BreedCollection.self) { response in
            
            guard let breedCollection = response.value else {
                completion(.failure(response.error!))
                return
            }
            completion(.success(breedCollection.breeds ?? []))
        }
    }
    
    func getListImagesByBreed(by name: String, completion: @escaping (Result<[Breed], Error>) -> Void) {
        AF.request("\(AppConstants.URL_DOG_CEO)/breed/\(name)/images").responseDecodable(of: [Breed].self) { response in
            guard let breedsImage = response.value else {
                completion(.failure(response.error!))
                return
            }
            completion(.success(breedsImage))
        }
    }
}
