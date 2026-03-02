//
//  LoginView.swift
//  ios-login-app
//
//  登录页面
//  功能：邮箱/密码登录，实时表单验证，错误提示，加载状态
//

import SwiftUI

// MARK: - LoginView

struct LoginView: View {
    // MARK: - Properties
    
    /// 登录成功回调
    let onLoginSuccess: () -> Void
    
    /// 登录服务
    private let loginService = MockLoginService()
    
    /// 登录服务实例（需要注入）
    @Environment(\.loginService) private var injectedLoginService
    
    // MARK: - State
    
    /// 表单状态
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    
    /// 验证状态
    @State private var emailError: String? = nil
    @State private var passwordError: String? = nil
    @State private var submitError: String? = nil
    
    /// 加载状态
    @State private var isLoading: Bool = false
    
    /// 显示测试账号
    @State private var showTestAccounts: Bool = true
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 24) {
            // Logo
            LogoView()
                .padding(.bottom, 16)
            
            // 标题
            Text("登录")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(hex: "#333333"))
                .padding(.bottom, 16)
            
            // 表单
            VStack(spacing: 16) {
                // 邮箱输入框
                InputField(
                    title: "邮箱",
                    placeholder: "请输入邮箱地址",
                    text: $email,
                    keyboardType: .emailAddress,
                    isError: emailError != nil,
                    errorMessage: emailError
                )
                .onChange(of: email) { _, newValue in
                    validateEmail(newValue)
                }
                
                // 密码输入框
                InputField(
                    title: "密码",
                    placeholder: "请输入密码",
                    text: $password,
                    isSecureTextEntry: !showPassword,
                    isError: passwordError != nil,
                    errorMessage: passwordError
                )
                .onChange(of: password) { _, newValue in
                    validatePassword(newValue)
                }
                
                // 密码显示/隐藏切换
                HStack {
                    Spacer()
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Text(showPassword ? "隐藏密码" : "显示密码")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#007AFF"))
                    }
                }
                
                // 登录按钮
                Button(
                    isLoading ? "登录中..." : "登录",
                    variant: .primary,
                    isEnabled: isFormValid() && !isLoading,
                    action: handleLogin
                )
                .disabled(isLoading)
                
                // 提交错误提示
                if let submitError = submitError {
                    Text(submitError)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#FF3B30"))
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#FFF5F5"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(hex: "#FF3B30"), lineWidth: 1)
                        )
                        .cornerRadius(4)
                }
            }
            
            Spacer()
            
            // 辅助链接
            VStack(spacing: 12) {
                Button("忘记密码？", variant: .secondary, action: {})
                    .frame(width: 200)
                
                HStack(spacing: 4) {
                    Text("还没有账号？")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#666666"))
                    
                    Button("立即注册", variant: .secondary, action: {})
                        .frame(width: 60)
                }
            }
            
            // 测试账号提示
            if showTestAccounts {
                TestAccountsView()
                    .padding(.bottom, 20)
            }
        }
        .padding()
        .background(Color.white)
    }
    
    // MARK: - Methods
    
    /// 验证邮箱
    private func validateEmail(_ email: String) {
        if email.isEmpty {
            emailError = nil
        } else if !loginService.validateEmail(email) {
            emailError = LoginErrorMessages[.invalidEmail]
        } else {
            emailError = nil
        }
    }
    
    /// 验证密码
    private func validatePassword(_ password: String) {
        if password.isEmpty {
            passwordError = nil
        } else {
            let result = loginService.validatePassword(password)
            passwordError = result.error
        }
    }
    
    /// 判断表单是否有效
    private func isFormValid() -> Bool {
        return !email.isEmpty &&
               !password.isEmpty &&
               emailError == nil &&
               passwordError == nil
    }
    
    /// 处理登录
    private func handleLogin() {
        // 清除之前的提交错误
        submitError = nil
        
        // 表单验证
        guard isFormValid() else {
            return
        }
        
        // 开始加载
        isLoading = true
        
        Task {
            do {
                let request = LoginRequest(email: email, password: password)
                let response = try await loginService.login(request: request)
                
                await MainActor.run {
                    if response.code == 200, let data = response.data {
                        // 登录成功
                        print("登录成功: \(data)")
                        
                        // 保存 Token 到 Keychain（需要实现）
                        // saveToken(data.token)
                        // saveUserId(data.userId)
                        
                        // 跳转到首页
                        onLoginSuccess()
                    } else {
                        // 登录失败
                        submitError = response.message
                    }
                    
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    // 网络错误
                    print("登录失败: \(error)")
                    submitError = LoginErrorMessages[.networkError]
                    isLoading = false
                }
            }
        }
    }
}

// MARK: - LogoView

/// Logo 视图
struct LogoView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "#007AFF"),
                            Color(hex: "#5AC8FA")
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 80, height: 80)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
            
            Text("L")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

// MARK: - TestAccountsView

/// 测试账号视图
struct TestAccountsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("测试账号：")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(hex: "#666666"))
            
            Text("邮箱: test@example.com / 密码: password123")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "#999999"))
            
            Text("邮箱: admin@example.com / 密码: admin123")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "#999999"))
        }
        .padding(16)
        .background(Color(hex: "#F5F5F5"))
        .cornerRadius(8)
    }
}

// MARK: - Environment

struct LoginServiceKey: EnvironmentKey {
    static let defaultValue: MockLoginService = MockLoginService()
}

extension EnvironmentValues {
    var loginService: MockLoginService {
        get { self[LoginServiceKey.self] }
        set { self[LoginServiceKey.self] = newValue }
    }
}

// MARK: - Preview

#Preview {
    LoginView(onLoginSuccess: {})
}
