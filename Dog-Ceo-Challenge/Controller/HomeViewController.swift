//
//  ViewController.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 09-08-21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var breed = [Breed]()
    let breedService: BreedService
    
    // MARK: - Initialization
    init(breedService: BreedService) {
        self.breedService = breedService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        breedService.getListBreeds{ [weak self] breedResult in
            
            switch breedResult {
            case .failure(let error):
                //ErrorPresenter.showError(message: "There was an error getting the acronyms", on: self)
                print("error: \(error) ")
            case .success(let breed):
                self?.breed = breed
                //self.tableView.reloadData()
                
            }
        }
        
       
    }
    
}
