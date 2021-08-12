//
//  ImagesBreeds.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 10-08-21.
//

import UIKit

class ImagesBreedsViewController: UIViewController {
    
    // MARK: - Properties
    var breedsImages = [Breed]()
    let breedService: BreedService
    let breed: String
    
    private var collectionView: UICollectionView?
    
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
        //view.backgroundColor = UIColor(red: 169 / 255, green: 223 / 255, blue: 224 / 255, alpha: 0.1)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width / 2) - 4,
                                 height: (view.frame.size.width / 2) - 4)
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        
        collectionView?.backgroundColor = UIColor(red: 179 / 255, green: 254 / 255, blue: 255 / 255, alpha: 1)
        
        guard let collectionView = collectionView else {
            return
        }
        
        breedService.getListImagesByBreed(by: self.breed,completion: { [weak self] breedResult in
            switch breedResult {
            case .failure(let error):
                //ErrorPresenter.showError(message: "There was an error getting the acronyms", on: self)
                print("error: \(error) ")
            case .success(let breeds):
                self?.breedsImages = breeds
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
    func breedImagesCollectionViewCell(cell: BreedImagesCollectionViewCell) {
        let alert = UIAlertController(title: "Felicidades", message: "Adoptaste a este perro", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
