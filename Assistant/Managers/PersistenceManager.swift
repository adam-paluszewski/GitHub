//
//  PersistenceManager.swift
//  GitHub
//
//  Created by Adam Paluszewski on 14/09/2022.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

struct PersistenceManager {
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static let shared = PersistenceManager()
    
    private let defaults = UserDefaults.standard
    
    
    func updateWith(favorite: Follower, actionType: PersistanceActionType, completionHandler: (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
                case .success(var favorites):
                    switch actionType {
                        case .add:
                            guard !favorites.contains(favorite) else {
                                completionHandler(.alreadyInFavorites)
                                return
                            }
                            favorites.append(favorite)
                        case .remove:
                            favorites.removeAll {$0.login == favorite.login}
                    }
                    
                    completionHandler(save(favorites: favorites))
                    
                case .failure(let error):
                    completionHandler(error)
            }
        }
    }
    
    
    func retrieveFavorites(completionHandler: (Result<[Follower],GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completionHandler(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completionHandler(.success(favorites))
        }
        catch {
            completionHandler(.failure(.unableToFavorites))
        }
    }
    
    
    func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
        }
        catch {
            return .unableToFavorites
        }
        return nil
    }
}
