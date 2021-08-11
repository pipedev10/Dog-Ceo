//
//  BreedImagesCollectionViewCell.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 10-08-21.
//

import UIKit

class BreedImagesCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "BreedImagesCollectionViewCell"
    
    private let imageBreed: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog-paw")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(imageBreed)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageBreed.frame = CGRect(x: 5,
                                  y: 0,
                                  width: contentView.frame.size.width,
                                  height: contentView.frame.size.height)
    }
    
    public func configure(UrlImage: String){
        self.imageBreed.load(urlString: UrlImage)
    }
    
    override func prepareForReuse() {
        self.imageBreed.image = nil
    }
}
