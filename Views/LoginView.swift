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
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 40)

                // Logo
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(hex: "#1890ff"))
                    .padding(.bottom, 24)

                // 标题
                Text("欢迎登录")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.bottom, 40)

                // 输入框容器
                VStack(spacing: 16) {
                    // 用户名输入
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                            .frame(width: 20)
                        TextField("请输入用户名", text: $username)
                            .textFieldStyle(PlainTextFieldStyle())
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                    // 密码输入
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                            .frame(width: 20)
                        SecureField("请输入密码", text: $password)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal, 24)

                // 错误提示
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 8)

                    Spacer()
                        .frame(height: 8)
                }

                // 登录按钮
                Button(action: login) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        }
                        Text(isLoading ? "登录中..." : "登录")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(username.isEmpty || password.isEmpty ? Color.gray : Color(hex: "#1890ff"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(isLoading || username.isEmpty || password.isEmpty)
                .padding(.horizontal, 24)

                Spacer()
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
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

// 修复颜色扩展 - 支持 6 位和 8 位 hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        if hex.count == 8 {
            // ARGB
            a = UInt32(int >> 24)
            r = UInt32(int >> 16 & 0xFF)
            g = UInt32(int >> 8 & 0xFF)
            b = UInt32(int & 0xFF)
        } else {
            // RGB (默认 alpha = 1.0)
            a = 255
            r = UInt32(int >> 16 & 0xFF)
            g = UInt32(int >> 8 & 0xFF)
            b = UInt32(int & 0xFF)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
