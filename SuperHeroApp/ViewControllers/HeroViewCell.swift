//
//  HeroViewCell.swift
//  SuperHeroApp
//
//  Created by Борис Павлов on 19.06.2022.
//

import UIKit

class HeroViewCell: UICollectionViewCell {
    @IBOutlet weak var heroImage: HeroImageView! {
        didSet {
            heroImage.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var nameLabel: UILabel!

    func configure(with index: SuperHeroModel?) {
        nameLabel.text = index?.name
        heroImage.fetchImage(from: index?.images.sm ?? "")
    }
}
