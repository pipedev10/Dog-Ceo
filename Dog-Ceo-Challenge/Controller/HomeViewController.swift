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
    let tableBreeds: UITableView = {
        let table = UITableView()
        table.register(BreedTableViewCell.self, forCellReuseIdentifier: BreedTableViewCell.identifier)
        return table
    }()
    
    
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
                self?.tableBreeds.reloadData()
                
            }
        }
        
        tableBreeds.dataSource = self
        tableBreeds.delegate = self
        
        view.addSubview(tableBreeds)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableBreeds.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableBreeds.dequeueReusableCell(withIdentifier: BreedTableViewCell.identifier, for: indexPath) as? BreedTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(text: breed[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
