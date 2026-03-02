//
//  InputField.swift
//  ios-login-app
//
//  通用输入框组件
//  基于设计稿样式：边框 #DDDDDD，边框宽度 1pt，圆角 4
//

import SwiftUI

/// 通用输入框组件
///
/// 使用规则：
/// 1. 默认使用单行文本输入
/// 2. 密码输入设置 secureTextEntry: true
/// 3. 邮箱输入设置 keyboardType: .emailAddress
/// 4. 输入框宽度建议使用 .fill 或固定宽度（如 300）
/// 5. 输入框高度固定为 40
/// 6. 错误状态设置 isError: true
struct InputField: View {
    // MARK: - Properties
    
    /// 输入框标题
    let title: String?
    
    /// 输入框占位符
    let placeholder: String
    
    /// 输入值绑定
    @Binding var text: String
    
    /// 键盘类型
    let keyboardType: UIKeyboardType
    
    /// 是否为密码输入
    let isSecureTextEntry: Bool
    
    /// 是否启用
    let isEnabled: Bool
    
    /// 是否有错误
    let isError: Bool
    
    /// 错误提示
    let errorMessage: String?
    
    /// 输入框宽度
    let width: CGFloat?
    
    /// 输入框高度
    let height: CGFloat
    
    /// 输入框内边距
    let padding: CGFloat
    
    // MARK: - Initialization
    
    /// 初始化输入框
    /// - Parameters:
    ///   - title: 输入框标题
    ///   - placeholder: 占位符（必填）
    ///   - text: 输入值绑定（必填）
    ///   - keyboardType: 键盘类型（默认：.default）
    ///   - isSecureTextEntry: 是否密码输入（默认：false）
    ///   - isEnabled: 是否启用（默认：true）
    ///   - isError: 是否有错误（默认：false）
    ///   - errorMessage: 错误提示
    ///   - width: 输入框宽度（默认：nil，使用自适应）
    ///   - height: 输入框高度（默认：40）
    ///   - padding: 内边距（默认：12）
    init(
        title: String? = nil,
        placeholder: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        isSecureTextEntry: Bool = false,
        isEnabled: Bool = true,
        isError: Bool = false,
        errorMessage: String? = nil,
        width: CGFloat? = nil,
        height: CGFloat = 40,
        padding: CGFloat = 12
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        self.isEnabled = isEnabled
        self.isError = isError
        self.errorMessage = errorMessage
        self.width = width
        self.height = height
        self.padding = padding
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // 标题
            if let title = title {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#333333"))
                    .fontWeight(isError ? .semibold : .regular)
            }
            
            // 输入框
            HStack(spacing: 8) {
                if let title = title, isError {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(Color(hex: "#FF3B30"))
                        .font(.system(size: 16))
                }
                
                if isSecureTextEntry {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "#333333"))
                } else {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "#333333"))
                        .keyboardType(keyboardType)
                }
            }
            .padding(.horizontal, padding)
            .frame(height: height)
            .frame(maxWidth: width.map { .constant($0) } ?? .infinity)
            .background(Color.white)
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(borderColor, lineWidth: 1)
            )
            .disabled(!isEnabled)
            .opacity(isEnabled ? 1.0 : 0.5)
            
            // 错误提示
            if isError, let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#FF3B30"))
            }
        }
    }
    
    // MARK: - Computed Properties
    
    private var borderColor: Color {
        if !isEnabled {
            return Color(hex: "#DDDDDD")
        } else if isError {
            return Color(hex: "#FF3B30")
        } else {
            return Color(hex: "#DDDDDD")
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
    VStack(spacing: 20) {
        InputField(
            title: "邮箱",
            placeholder: "请输入邮箱",
            text: .constant(""),
            keyboardType: .emailAddress
        )
        .frame(width: 300)
        
        InputField(
            title: "密码",
            placeholder: "请输入密码",
            text: .constant(""),
            isSecureTextEntry: true
        )
        .frame(width: 300)
        
        InputField(
            title: "手机号",
            placeholder: "请输入手机号",
            text: .constant(""),
            keyboardType: .phonePad
        )
        .frame(width: 300)
        
        InputField(
            title: "邮箱",
            placeholder: "请输入邮箱",
            text: .constant("invalid"),
            isError: true,
            errorMessage: "邮箱格式不正确"
        )
        .frame(width: 300)
        
        InputField(
            placeholder: "禁用状态",
            text: .constant(""),
            isEnabled: false
        )
        .frame(width: 300)
    }
    .padding()
    .background(Color(hex: "#F5F5F5"))
}
