//
//  NetworkManager.swift
//  SuperHeroApp
//
//  Created by Борис Павлов on 19.06.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(with url: String) async throws -> [SuperHeroModel] {
        guard let url = URL(string: Link.heroUrl.rawValue) else {
            throw NetworkError.invalidURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        
        guard let character = try? decoder.decode([SuperHeroModel].self, from: data) else {
            throw NetworkError.noData}
        
        return character
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
                print(NetworkError.invalidURL)
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
