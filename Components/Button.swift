//
//  Button.swift
//  ios-login-app
//
//  通用登录按钮组件
//  基于设计稿样式：背景色 #007AFF，文字颜色 #FFFFFF，圆角 4
//

import SwiftUI

/// 通用登录按钮组件
///
/// 使用规则：
/// 1. 主要操作按钮使用默认样式（蓝色背景）
/// 2. 次要操作按钮使用 variant: .secondary
/// 3. 禁用状态设置 isEnabled: false
/// 4. 按钮宽度建议使用 .fill 或固定宽度（如 300）
/// 5. 按钮高度固定为 44
struct Button: View {
    // MARK: - Properties
    
    /// 按钮文字
    let title: String
    
    /// 按钮点击事件
    let action: () -> Void
    
    /// 按钮样式变体
    let variant: ButtonVariant
    
    /// 是否可用
    let isEnabled: Bool
    
    /// 按钮宽度
    let width: CGFloat?
    
    /// 按钮高度
    let height: CGFloat
    
    // MARK: - Initialization
    
    /// 初始化按钮
    /// - Parameters:
    ///   - title: 按钮文字
    ///   - variant: 按钮样式变体（默认：.primary）
    ///   - isEnabled: 是否可用（默认：true）
    ///   - width: 按钮宽度（默认：nil，使用自适应）
    ///   - height: 按钮高度（默认：44）
    ///   - action: 点击事件
    init(
        _ title: String,
        variant: ButtonVariant = .primary,
        isEnabled: Bool = true,
        width: CGFloat? = nil,
        height: CGFloat = 44,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.isEnabled = isEnabled
        self.width = width
        self.height = height
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        SwiftUI.Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(foregroundColor)
                .frame(maxWidth: width.map { .constant($0) } ?? .infinity)
                .frame(height: height)
                .background(backgroundColor)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.5)
    }
    
    // MARK: - Computed Properties
    
    private var backgroundColor: Color {
        switch variant {
        case .primary:
            return isEnabled ? Color(hex: "#007AFF") : Color(hex: "#E5E5E5")
        case .secondary:
            return isEnabled ? Color(hex: "#FFFFFF") : Color(hex: "#E5E5E5")
        case .danger:
            return isEnabled ? Color(hex: "#FF3B30") : Color(hex: "#E5E5E5")
        }
    }
    
    private var foregroundColor: Color {
        switch variant {
        case .primary:
            return isEnabled ? Color(hex: "#FFFFFF") : Color(hex: "#999999")
        case .secondary:
            return isEnabled ? Color(hex: "#007AFF") : Color(hex: "#999999")
        case .danger:
            return isEnabled ? Color(hex: "#FFFFFF") : Color(hex: "#999999")
        }
    }
    
    private var borderColor: Color {
        switch variant {
        case .primary:
            return Color.clear
        case .secondary:
            return isEnabled ? Color(hex: "#007AFF") : Color(hex: "#DDDDDD")
        case .danger:
            return Color.clear
        }
    }
    
    private var borderWidth: CGFloat {
        switch variant {
        case .primary:
            return 0
        case .secondary:
            return 1
        case .danger:
            return 0
        }
    }
}

// MARK: - ButtonVariant

/// 按钮样式变体
enum ButtonVariant {
    /// 主要按钮（蓝色背景，白色文字）
    case primary
    /// 次要按钮（白色背景，蓝色文字，蓝色边框）
    case secondary
    /// 危险按钮（红色背景，白色文字）
    case danger
}

// MARK: - Color Extension

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
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
    VStack(spacing: 20) {
        Button("登录", action: {})
            .frame(width: 300)
        
        Button("注册", variant: .secondary, action: {})
            .frame(width: 300)
        
        Button("退出登录", variant: .danger, action: {})
            .frame(width: 300)
        
        Button("禁用状态", isEnabled: false, action: {})
            .frame(width: 300)
    }
    .padding()
}
