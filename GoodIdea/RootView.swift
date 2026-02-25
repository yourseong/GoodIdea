// 홈 화면 ("아이디어 검색하기")

import SwiftUI
import SwiftData

struct RootView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                
                Text("Good Idea")
                    .font(.largeTitle)
                    .bold()
                
                Text("내가 생각한 아이디어를 검색하고 피드백을 받아보세요")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                NavigationLink {
                    SearchView()
                } label: {
                    Text("아이디어 검색하기")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue) //
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
            //            .navigationTitle("홈")
        }
    }
}

#Preview {
    RootView()
}
