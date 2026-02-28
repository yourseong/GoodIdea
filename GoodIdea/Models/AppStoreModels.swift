//
//  AppStoreModels.swift
//  GoodIdea
//
//  Created by 채유성 on 2/25/26.
//
//

struct AppStoreResponse: Decodable { // Decodale : Json -> Swift로 변환
    let results: [AppStoreApp]
}


struct AppStoreApp: Decodable, Identifiable {
    let trackId: Int            // 앱 고유 ID
    let trackName: String       // 앱 이름
    let artworkUrl100: String   // 앱 아이콘

    var id: Int { trackId }     // Identifiable 요구사항
}
