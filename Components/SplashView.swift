//
//  SplashView.swift
//  ios-login-app
//
//  启动页面组件
//  展示品牌 Logo 和加载动画
//

import SwiftUI

/// 启动页面视图
///
/// 使用规则：
/// 1. 作为应用启动时的第一个页面
/// 2. 自动跳转到登录页面（延迟 2 秒）
/// 3. 显示品牌 Logo 和加载动画
struct SplashView: View {
    // MARK: - Properties
    
    /// 是否显示加载完成
    @State private var isLoaded: Bool = false
    
    /// 加载动画进度
    @State private var progress: Double = 0.0
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Logo
            logoView
            
            // 品牌名称
            brandName
            
            // 加载动画
            loadingIndicator
            
            Spacer()
            
            // 版本信息
            versionInfo
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#FFFFFF"))
        .onAppear {
            startLoading()
        }
    }
    
    // MARK: - Logo View
    
    private var logoView: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#007AFF"), Color(hex: "#5AC8FA")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 100, height: 100)
            
            Text("L")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.white)
        }
        .shadow(radius: 10)
    }
    
    // MARK: - Brand Name
    
    private var brandName: some View {
        Text("LoginApp")
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(Color(hex: "#333333"))
            .opacity(isLoaded ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.5), value: isLoaded)
    }
    
    // MARK: - Loading Indicator
    
    private var loadingIndicator: some View {
        VStack(spacing: 12) {
            // 进度条
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // 背景条
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(hex: "#E5E5E5"))
                        .frame(height: 4)
                    
                    // 进度条
                    RoundedRectangle(cornerRadius: 2)
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "#007AFF"), Color(hex: "#5AC8FA")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * progress, height: 4)
                }
            }
            .frame(height: 4)
            .frame(maxWidth: 200)
            
            // 加载文字
            Text("正在加载...")
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "#999999"))
        }
    }
    
    // MARK: - Version Info
    
    private var versionInfo: some View {
        VStack(spacing: 4) {
            Text("Version 1.0.0")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "#999999"))
            
            Text("© 2026 Multi-Platform App")
                .font(.system(size: 10))
                .foregroundColor(Color(hex: "#CCCCCC"))
        }
        .padding(.bottom, 40)
    }
    
    // MARK: - Methods
    
    private func startLoading() {
        // 模拟加载进度
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            progress += 0.05
            
            if progress >= 1.0 {
                timer.invalidate()
                isLoaded = true
                
                // 延迟 0.5 秒后跳转
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // TODO: 跳转到登录页面
                    // navigationManager.navigateToLogin()
                }
            }
        }
    }
}

// MARK: - Color Extension

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Preview

#Preview {
    SplashView()
}
