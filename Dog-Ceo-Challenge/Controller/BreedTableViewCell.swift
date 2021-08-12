//
//  BreedTableViewCell.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 09-08-21.
//

import UIKit

class BreedTableViewCell: UITableViewCell {
    static let identifier = "BreedTableViewCell"
    
    // MARK: - Properties
    private let iconBreed: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "dog-paw")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let labelBreed: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 179 / 255, green: 254 / 255, blue: 255 / 255, alpha: 1)
        
        contentView.addSubview(iconBreed)
        contentView.addSubview(labelBreed)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            iconBreed.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconBreed.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconBreed.heightAnchor.constraint(equalToConstant: 35),
            iconBreed.widthAnchor.constraint(equalToConstant: 35),
        ])
        
        NSLayoutConstraint.activate([
            labelBreed.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelBreed.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    public func configure(text: String){
        self.labelBreed.text = text
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelBreed.text = nil
    }
}
