//
//  LoginView.swift
//  LoginApp
//
//  Created by Generated Code
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(hex: "#1890ff"))
                .padding(.top, 60)

            Text("欢迎登录")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("请输入用户名", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300, height: 40)
                .font(.system(size: 14))

            SecureField("请输入密码", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300, height: 40)
                .font(.system(size: 14))

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button(action: login) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("登录")
                        .fontWeight(.medium)
                }
            }
            .frame(width: 200, height: 40)
            .background(Color(hex: "#1890ff"))
            .foregroundColor(.white)
            .cornerRadius(4)
            .disabled(isLoading || username.isEmpty || password.isEmpty)

            Spacer()
        }
        .padding()
    }

    private func login() {
        isLoading = true
        errorMessage = nil

        // 模拟登录
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            if username == "admin" && password == "123456" {
                // 登录成功
                print("登录成功")
            } else {
                errorMessage = "用户名或密码错误"
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b = UInt32(int >> 24), UInt32(int >> 16 & 0xFF), UInt32(int >> 8 & 0xFF), UInt32(int & 0xFF)
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
