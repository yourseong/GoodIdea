// 분석 화면
// branch test

import SwiftUI

// MARK: - View

struct AnalyticsView: View {
    let keyword: String
    
    @State private var apps: [AppStoreApp] = []
    @State private var isLoading = false
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                if apps.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        Text("검색 결과가 없습니다")
                            .foregroundStyle(.secondary)
                    }
                }
                else {
                    List {
                        ForEach(apps) { app in
                            HStack(spacing: 16) {
                                
                                AsyncImage(url: URL(string: app.artworkUrl100)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 70, height: 70)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .frame(width: 70, height: 70)
                                            .background(Color.gray.opacity(0.15))
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(app.trackName)
                                        .font(.headline)
                                        .lineLimit(2)
                                    
                                    Text("App Store 검색 결과")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .listStyle(.plain)
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
        "https://itunes.apple.com/search?term=\(encoded)&entity=software&limit=10&country=KR"
        
        guard let url = URL(string: urlString) else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let result = try JSONDecoder().decode(AppStoreResponse.self, from: data)
                apps = result.results
            } catch {
                print(error)
            }
            isLoading = false
        }
    }
}

#Preview {
    NavigationStack {
        AnalyticsView(keyword: "지도")
    }
}
