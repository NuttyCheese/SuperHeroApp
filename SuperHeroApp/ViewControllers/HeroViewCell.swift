//
//  HeroViewCell.swift
//  SuperHeroApp
//
//  Created by Борис Павлов on 19.06.2022.
//

import UIKit

class HeroViewCell: UICollectionViewCell {
    @IBOutlet weak var heroImage: UIImageView! {
        didSet {
            heroImage.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
            nameLabel.textColor = .white
        }
    }


    func configure(with index: SuperHeroModel?) {
        nameLabel.text = index?.name
        DispatchQueue.global().async {
            guard let stringUrl = index?.images.sm else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.heroImage.image = UIImage(data: imageData)
            }
        }
    }
}
