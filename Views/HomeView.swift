//
//  HomeView.swift
//  ios-login-app
//
//  首页
//  登录成功后的首页
//

import SwiftUI

// MARK: - HomeView

struct HomeView: View {
    // MARK: - Properties
    
    /// 退出登录回调
    let onLogout: () -> Void
    
    /// 用户 ID
    private let userId: String
    
    // MARK: - Initialization
    
    init(userId: String = "未知用户", onLogout: @escaping () -> Void) {
        self.userId = userId
        self.onLogout = onLogout
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 24) {
            // Logo
            LogoView()
            
            // 标题
            Text("首页")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(hex: "#333333"))
            
            // 欢迎信息
            Text("欢迎回来，\(userId)")
                .font(.system(size: 16))
                .foregroundColor(Color(hex: "#666666"))
            
            // 登出按钮
            Button("退出登录", variant: .primary, action: onLogout)
                .frame(width: 300)
            
            Spacer()
            
            // 功能列表
            VStack(spacing: 16) {
                Text("更多功能开发中...")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#999999"))
            }
        }
        .padding()
        .background(Color.white)
    }
}

// MARK: - LogoView

/// Logo 视图
struct HomeLogoView: View {
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
            
            Text("H")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView(userId: "MOCK_USER_001", onLogout: {})
}
