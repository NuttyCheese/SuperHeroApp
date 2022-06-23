//
//  HeroViewController.swift
//  SuperHeroApp
//
//  Created by Борис Павлов on 19.06.2022.
//

import UIKit

class HeroViewController: UIViewController {
    @IBOutlet weak var imageHero: HeroImageView! {
        didSet {
            imageHero.contentMode = .scaleAspectFill
            imageHero.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var powerstatsLabel: UILabel!
    @IBOutlet weak var appearanceLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    
    var superHeroModel: SuperHeroModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    private func fetchImage() {
        nameLabel.text = superHeroModel.name
        
        powerstatsLabel.text = "Статистика мощности: \n    Интеллект: \(superHeroModel.powerstats.intelligence) \n    Прочность: \(superHeroModel.powerstats.strength) \n    Скорость: \(superHeroModel.powerstats.speed) \n    Живучесть: \(superHeroModel.powerstats.durability) \n    Сила: \(superHeroModel.powerstats.power) \n    Командная работа: \(superHeroModel.powerstats.combat)"
        
        appearanceLabel.text = "Внешний вид: \n    Пол: \(superHeroModel.appearance.gender) \n    Рост: \(superHeroModel.appearance.height.last ?? "_") \n    Вес: \(superHeroModel.appearance.weight.last ?? "_")"
        
        biographyLabel.text = "Биография: \n    Полное имя: \(superHeroModel.biography.fullName) \n    Вторая личность: \(superHeroModel.biography.alterEgos) \n    Псевдоним: \(superHeroModel.biography.aliases.first ?? "_") \n    Первое появление: \(superHeroModel.biography.firstAppearance) \n    Сторона силы: \(superHeroModel.biography.alignment)"
        
        workLabel.text = "Работа: \n    Место работы: \(superHeroModel.work.occupation)"
        
        imageHero.fetchImage(from: superHeroModel.images.lg)
    }
}
