//
//  GFError.swift
//  GitHub
//
//  Created by Adam Paluszewski on 13/09/2022.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This user created a invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "Data received from the server was invalid. Please try again"
    case unableToFavorites = "There was error. Please try again."
    case alreadyInFavorites = "This user is already in favorites"
}
