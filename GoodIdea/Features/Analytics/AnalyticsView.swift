// 분석 화면

import SwiftUI

struct AnalyticsView: View {
    let keyword: String
    
    @State private var apps: [String] = []
    @State private var isLoading = false
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                List(apps, id: \.self) { app in
                    Text(app)
                }
            }
        }
        .navigationTitle("검색 결과")
        .onAppear {
            fetchAppStoreApps()
        }
    }
    
    private func fetchAppStoreApps() {
        isLoading = true
        
        let encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString =
        "https://itunes.apple.com/search?term=\(encoded)&entity=software&limit=10"
        
        guard let url = URL(string: urlString) else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let result = try JSONDecoder().decode(AppStoreResponse.self, from: data)
                apps = result.results.map { $0.trackName }
            } catch {
                print(error)
            }
            isLoading = false
        }
    }
}

#Preview {
    AnalyticsView(keyword: "아이디어")
}
