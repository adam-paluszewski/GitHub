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
    
    static private let defaults = UserDefaults.standard
    
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completionHandler: (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
                case .success(let favorites):
                    var retrievedFavorites = favorites
            
                    switch actionType {
                        case .add:
                            guard !retrievedFavorites.contains(favorite) else {
                                completionHandler(.alreadyInFavorites)
                                return
                            }
                            retrievedFavorites.append(favorite)
                        case .remove:
                            retrievedFavorites.removeAll {$0.login == favorite.login}
                    }
                    
                    completionHandler(save(favorites: retrievedFavorites))
                    
                case .failure(let error):
                    completionHandler(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completionHandler: (Result<[Follower],GFError>) -> Void) {
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
    
    
    static func save(favorites: [Follower]) -> GFError? {
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
