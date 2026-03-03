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
        VStack(spacing: 24) {
            Text("欢迎回来！")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("您已成功登录")
                .font(.title2)
                .foregroundColor(.secondary)

            Spacer()

            Button(action: { isLoggedIn = false }) {
                Text("退出登录")
                    .fontWeight(.medium)
            }
            .frame(width: 200, height: 40)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(4)
            .padding(.bottom, 40)
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
