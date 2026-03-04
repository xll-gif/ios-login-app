//
//  HomeView.swift
//  LoginApp
//
//  Created by Generated Code
//

import SwiftUI

struct HomeView: View {
    @State private var isLoggedIn = true

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 80)

                // 成功图标
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
                    .padding(.bottom, 24)

                Text("欢迎回来！")
                    .font(.title)
                    .fontWeight(.bold)

                Text("您已成功登录")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 48)

                Button(action: { isLoggedIn = false }) {
                    Text("退出登录")
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
