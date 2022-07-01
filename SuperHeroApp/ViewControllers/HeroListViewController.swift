//
//  HeroListViewController.swift
//  SuperHeroApp
//
//  Created by Борис Павлов on 19.06.2022.
//

import UIKit

class HeroListViewController: UICollectionViewController, UISearchResultsUpdating {
    private var superHeroModel: [SuperHeroModel] = []
    private var filtredHeroes: [SuperHeroModel] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupSearchController()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltering ? filtredHeroes.count : superHeroModel.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroViewCell
        let hero = isFiltering ? filtredHeroes[indexPath.item] : superHeroModel[indexPath.item]
        cell.configure(with: hero)
        return cell
    }
    
    private func fetchData() {
        Task {
            do {
                let heroModel = try await NetworkManager.shared.fetchData(with: Link.heroUrl.rawValue)
                superHeroModel = heroModel
                collectionView.reloadData()
            }catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = collectionView.indexPathsForSelectedItems else { return }
        let hero = isFiltering ? filtredHeroes[index.first?.item ?? 0] : superHeroModel[index.first?.item ?? 0]
        let vc = segue.destination as! HeroViewController
        vc.superHeroModel = hero
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filtredHeroes = superHeroModel.filter { character in
            character.name.lowercased().contains(searchText.lowercased())
        }
        
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HeroListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 160 , height: 200)
    }
}
