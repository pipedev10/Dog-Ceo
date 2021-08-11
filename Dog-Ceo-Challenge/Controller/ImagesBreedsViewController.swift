//
//  ImagesBreeds.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 10-08-21.
//

import UIKit

class ImagesBreedsViewController: UIViewController {
    
    // MARK: - Properties
    var breed = [Breed]()
    let breedService: BreedService
    
    private var collectionView: UICollectionView?
    
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
        view.backgroundColor = .red
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width / 2) - 4,
                                 height: (view.frame.size.width / 2) - 4)
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        breedService.getListImagesByBreed(by: "akita",completion: { [weak self] breedResult in
            switch breedResult {
            case .failure(let error):
                //ErrorPresenter.showError(message: "There was an error getting the acronyms", on: self)
                print("error: \(error) ")
            case .success(let breed):
                self?.breed = breed
                self?.collectionView?.reloadData()
            }
        })
        
        collectionView.register(BreedImagesCollectionViewCell.self, forCellWithReuseIdentifier: BreedImagesCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}
// MARK: - Setup CollectionView
extension ImagesBreedsViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breed.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedImagesCollectionViewCell.identifier, for: indexPath) as? BreedImagesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(UrlImage: breed[indexPath.row])
        return cell
    }
}
