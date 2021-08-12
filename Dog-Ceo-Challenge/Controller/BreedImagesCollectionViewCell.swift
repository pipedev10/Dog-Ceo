//
//  BreedImagesCollectionViewCell.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 10-08-21.
//

import UIKit

protocol BreedImagesCollectionViewCellDelegate: AnyObject {
    func breedImagesCollectionViewCell(cell: BreedImagesCollectionViewCell)
}

class BreedImagesCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "BreedImagesCollectionViewCell"
    weak var delegate: BreedImagesCollectionViewCellDelegate?
    
    private let imageBreed: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Dog-Ceo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var btnAdoptMe: UIButton = {
        let button = UIButton()
        button.setTitle("Adoptame", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 179 / 255, green: 254 / 255, blue: 255 / 255, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.addTarget(self, action: #selector(didTapAdoptDog), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(imageBreed)
        contentView.addSubview(btnAdoptMe)
        
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            imageBreed.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageBreed.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageBreed.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBreed.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            btnAdoptMe.centerXAnchor.constraint(equalTo: imageBreed.centerXAnchor),
            btnAdoptMe.bottomAnchor.constraint(equalTo: imageBreed.bottomAnchor, constant: -5),
            btnAdoptMe.leadingAnchor.constraint(equalTo: imageBreed.leadingAnchor, constant: 16)
        ])
    }
    
    public func configure(UrlImage: String){
        self.imageBreed.load(urlString: UrlImage)
    }
    
    override func prepareForReuse() {
        self.imageBreed.image = nil
    }
    
    @objc func didTapAdoptDog(){
        delegate?.breedImagesCollectionViewCell(cell: self)
    }
}
