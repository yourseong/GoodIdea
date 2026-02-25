// 검색 화면

import SwiftUI
import SwiftData

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var path: [String] = [] // String 상태 선언
    
    var body: some View {
        NavigationStack(path: $path) {
            
            
            VStack {
                
                
                TextField("아이디어를 입력하세요", text: $searchText)
                
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 24)
                    .submitLabel(.search)
                    .onSubmit { // 엔터 쳤을 때
                        guard !searchText.isEmpty else { return }
                        path.append(searchText) // 화면 이동 트리거
                    }
                
            }
            .navigationTitle("검색")
            .navigationDestination(for: String.self) {
                idea in AnalyticsView(keyword: idea)
                
            }
            
            
        }
    }
}

#Preview {
    SearchView()
        .modelContainer(for: Item.self, inMemory: true)
}
