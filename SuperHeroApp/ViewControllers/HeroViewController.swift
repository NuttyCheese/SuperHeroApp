//
//  HeroViewController.swift
//  SuperHeroApp
//
//  Created by Борис Павлов on 19.06.2022.
//

import UIKit

class HeroViewController: UIViewController {
    @IBOutlet weak var imageHero: UIImageView! {
        didSet {
            imageHero.contentMode = .scaleAspectFill
            imageHero.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
            nameLabel.textColor = .white
        }
    }
    @IBOutlet weak var powerstatsLabel: UILabel! {
        didSet {
            powerstatsLabel.numberOfLines = 0
            powerstatsLabel.font = UIFont.boldSystemFont(ofSize: 15)
            powerstatsLabel.textColor = .white
        }
    }
    @IBOutlet weak var appearanceLabel: UILabel! {
        didSet {
            appearanceLabel.numberOfLines = 0
            appearanceLabel.font = UIFont.boldSystemFont(ofSize: 15)
            appearanceLabel.textColor = .white
        }
    }
    @IBOutlet weak var biographyLabel: UILabel! {
        didSet {
            biographyLabel.numberOfLines = 0
            biographyLabel.font = UIFont.boldSystemFont(ofSize: 15)
            biographyLabel.textColor = .white
        }
    }
    @IBOutlet weak var workLabel: UILabel! {
        didSet {
            workLabel.numberOfLines = 0
            workLabel.font = UIFont.boldSystemFont(ofSize: 15)
            workLabel.textColor = .white
        }
    }
    
    var superHeroModel: SuperHeroModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        fetchImage()
    }
    
    private func fetchImage() {
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: self.superHeroModel.images.lg) else { return }
            DispatchQueue.main.async {
                self.imageHero.image = UIImage(data: imageData)
                self.nameLabel.text = self.superHeroModel.name
                self.powerstatsLabel.text = "Статистика мощности: \n    Интеллект: \(self.superHeroModel.powerstats.intelligence) \n    Прочность: \(self.superHeroModel.powerstats.strength) \n    Скорость: \(self.superHeroModel.powerstats.speed) \n    Живучесть: \(self.superHeroModel.powerstats.durability) \n    Сила: \(self.superHeroModel.powerstats.power) \n    Командная работа: \(self.superHeroModel.powerstats.combat)"
                
                self.appearanceLabel.text = "Внешний вид: \n    Пол: \(self.superHeroModel.appearance.gender) \n    Рост: \(self.superHeroModel.appearance.height.last ?? "_") \n    Вес: \(self.superHeroModel.appearance.weight.last ?? "_")"
                
                
                self.biographyLabel.text = "Биография: \n    Полное имя: \(self.superHeroModel.biography.fullName) \n    Вторая личность: \(self.superHeroModel.biography.alterEgos) \n    Псевдоним: \(self.superHeroModel.biography.aliases.first ?? "_") \n    Первое появление: \(self.superHeroModel.biography.firstAppearance) \n    Сторона силы: \(self.superHeroModel.biography.alignment)"
                
                self.workLabel.text = "Работа: \n    Место работы: \(self.superHeroModel.work.occupation)"
            }
        }
    }
}
