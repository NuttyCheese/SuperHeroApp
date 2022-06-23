//
//  NetworkManager.swift
//  SuperHeroApp
//
//  Created by Борис Павлов on 19.06.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(with url: String, completion: @escaping([SuperHeroModel]) -> ()) {
        guard let url = URL(string: Link.heroUrl.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "error")
                return
            }
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode([SuperHeroModel].self, from: data)
                DispatchQueue.main.async {
                    completion(model)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
    
    private init() {}
}

class ImageManager {
    static var shared = ImageManager()
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) ->Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
    private init() {}
}
