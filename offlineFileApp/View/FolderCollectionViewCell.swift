//
//  FolderCollectionViewCell.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 11/01/25.
//

import UIKit
import SwiftUI

class FolderCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let favouriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        dateLabel.textColor = .secondaryLabel
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 2
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
        
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favouriteButton.tintColor = .systemRed
        favouriteButton.backgroundColor = .secondarySystemBackground
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.layer.cornerRadius = 12
        favouriteButton.clipsToBounds = true
        contentView.addSubview(favouriteButton)
        
        NSLayoutConstraint.activate([
            favouriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favouriteButton.widthAnchor.constraint(equalToConstant: 24),
            favouriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with folder: Folder) {
        imageView.image = UIImage(systemName: "folder.fill")
        imageView.tintColor = UIColor(hex: folder.color!)
        titleLabel.text = folder.name ?? "Unnamed"
        dateLabel.text = DateFormatter.dateFormatter.string(from: folder.creation!)
        let redColor = UIColor(hex: "#FF4040")
        favouriteButton.tintColor = folder.favourite ? redColor : .lightGray
    }
}
