//
//  ImagesBreeds.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 10-08-21.
//

import UIKit

class ImagesBreedsViewController: UIViewController {
    
    // MARK: - Properties
    private var breedsImages = [Breed]()
    private let breedService: BreedService
    private let breed: String
    
    private var collectionView: UICollectionView?
    private let loadingVC = LoadingViewController()
    
    // MARK: - Initialization
    init(breedService: BreedService, breed: String) {
        self.breedService = breedService
        self.breed = breed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getImagesBreeds()
    }
    
    func setupUI(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width / 2) - 4,
                                 height: (view.frame.size.width / 2) - 4)
        navigationController?.navigationBar.tintColor = .black
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        
        collectionView?.backgroundColor = UIColor.primaryColor
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(BreedImagesCollectionViewCell.self, forCellWithReuseIdentifier: BreedImagesCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    func getImagesBreeds(){
        breedService.getListImagesByBreed(by: self.breed,completion: { [weak self] breedResult in
            switch breedResult {
            case .failure(let error):
                self?.showAlert(alertMessage: "Hubo un error, favor intente más tarde. \(error)")
            case .success(let breeds):
                self?.breedsImages = breeds
                self?.collectionView?.reloadData()
            }
        })
    }
}
// MARK: - Setup CollectionView
extension ImagesBreedsViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breedsImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedImagesCollectionViewCell.identifier, for: indexPath) as? BreedImagesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(UrlImage: breedsImages[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension ImagesBreedsViewController: BreedImagesCollectionViewCellDelegate {
    func didTapAdoptButton() {
        self.showAlert(alertMessage: "MessageAdoptDog".localized, alertTitle: "Congrats".localized)
    }
}
