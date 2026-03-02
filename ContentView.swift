//
//  ContentView.swift
//  ios-login-app
//
//  主应用视图
//  路由配置：启动页 -> 登录页 -> 首页
//

import SwiftUI

// MARK: - AppView

struct AppView: View {
    // MARK: - State
    
    /// 当前路由
    @State private var currentRoute: AppRoute = .splash
    
    /// 是否已登录
    @State private var isLoggedIn: Bool = false
    
    /// 用户 ID
    @State private var userId: String = ""
    
    // MARK: - Body
    
    var body: some View {
        switch currentRoute {
        case .splash:
            SplashView(
                onLoadingComplete: {
                    currentRoute = .login
                }
            )
        case .login:
            LoginView(
                onLoginSuccess: {
                    isLoggedIn = true
                    userId = "MOCK_USER_001" // 从登录响应中获取
                    currentRoute = .home
                }
            )
        case .home:
            if isLoggedIn {
                HomeView(
                    userId: userId,
                    onLogout: {
                        isLoggedIn = false
                        userId = ""
                        currentRoute = .login
                    }
                )
            } else {
                LoginView(
                    onLoginSuccess: {
                        isLoggedIn = true
                        userId = "MOCK_USER_001"
                        currentRoute = .home
                    }
                )
            }
        }
    }
}

// MARK: - AppRoute

/// 应用路由
enum AppRoute {
    case splash
    case login
    case home
}

// MARK: - Preview

#Preview {
    AppView()
}
