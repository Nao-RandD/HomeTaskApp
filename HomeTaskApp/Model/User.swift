//
//  User.swift
//  HomeTaskApp
//
//  Created by Naoyuki Kan on 2021/07/14.
//

import Foundation

// ユーザーの列挙
enum User: CaseIterable {
    case Shin
    case Nao
    case Ryoya

    var name: String {
        switch self {
        case .Shin:
            return "Shin"
        case .Nao:
            return "Nao"
        case .Ryoya:
            return "Ryoya"
        }
    }
}
