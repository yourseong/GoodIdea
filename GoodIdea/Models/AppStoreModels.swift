//
//  AppStoreModels.swift
//  GoodIdea
//
//  Created by 채유성 on 2/25/26.
//

struct AppStoreResponse: Decodable {
    let results: [AppStoreApp]
}

struct AppStoreApp: Decodable {
    let trackName: String
}
