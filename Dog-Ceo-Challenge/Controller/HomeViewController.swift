//
//  ViewController.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 09-08-21.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Properties
    private var breed = [Breed]()
    private let breedService: BreedService
    private let tableBreeds: UITableView = {
        let table = UITableView()
        table.register(BreedTableViewCell.self, forCellReuseIdentifier: BreedTableViewCell.identifier)
        return table
    }()
    
    private let loadingVC = LoadingViewController()
    
    
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
        title = "Title".localized
        view.backgroundColor = UIColor.primaryColor
        loadingVC.modalPresentationStyle = .overCurrentContext
        present(loadingVC, animated: true)
        
        breedService.getListBreeds{ [weak self] breedResult in
            switch breedResult {
            case .failure(let error):
                self?.showAlert(alertMessage: "Hubo un error, favor intente más tarde. \(error)")
            case .success(let breed):
                self?.breed = breed
                self?.tableBreeds.reloadData()
                
            }
            self?.loadingVC.dismiss(animated: true)
        }
        
        
        tableBreeds.dataSource = self
        tableBreeds.delegate = self
        
        view.addSubview(tableBreeds)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableBreeds.deselectRow(at: indexPath, animated: true)
        let vc = ImagesBreedsViewController(breedService: breedService, breed: breed[indexPath.row])
        vc.title = breed[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
