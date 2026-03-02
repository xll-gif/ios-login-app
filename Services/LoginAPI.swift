//
//  LoginAPI.swift
//  ios-login-app
//
//  登录 API 服务
//

import Foundation

// MARK: - LoginRequest

/// 登录请求参数
struct LoginRequest: Codable {
    let email: String
    let password: String
}

// MARK: - LoginResponse

/// 登录响应数据
struct LoginResponse: Codable {
    let token: String
    let refreshToken: String
    let userId: String
    let email: String
    let nickname: String
    let avatar: String
    let expiresIn: Int
}

// MARK: - APIResponse

/// API 响应格式
struct APIResponse<T: Codable>: Codable {
    let code: Int
    let message: String
    let data: T?
}

// MARK: - LoginErrorType

/// 登录错误类型
enum LoginErrorType: String, Error {
    case invalidEmail = "INVALID_EMAIL"
    case passwordTooShort = "PASSWORD_TOO_SHORT"
    case passwordTooLong = "PASSWORD_TOO_LONG"
    case invalidCredentials = "INVALID_CREDENTIALS"
    case accountLocked = "ACCOUNT_LOCKED"
    case networkError = "NETWORK_ERROR"
    case serverError = "SERVER_ERROR"
}

// MARK: - LoginErrorMessages

/// 登录错误信息
let LoginErrorMessages: [LoginErrorType: String] = [
    .invalidEmail: "请输入有效的邮箱地址",
    .passwordTooShort: "密码至少需要 6 个字符",
    .passwordTooLong: "密码不能超过 20 个字符",
    .invalidCredentials: "邮箱或密码错误，请重试",
    .accountLocked: "账号已被锁定，请联系客服",
    .networkError: "网络连接失败，请检查网络设置",
    .serverError: "服务器繁忙，请稍后再试",
]

// MARK: - MockLoginService

/// Mock 登录服务
class MockLoginService {
    
    // MARK: - Properties
    
    /// Mock 延迟时间（秒）
    private let mockDelay: TimeInterval = 1.0
    
    /// Mock 用户数据库
    private let mockUsers: [(email: String, password: String, userId: String, nickname: String, avatar: String)] = [
        ("test@example.com", "password123", "MOCK_USER_001", "测试用户", "https://via.placeholder.com/100"),
        ("admin@example.com", "admin123", "MOCK_USER_002", "管理员", "https://via.placeholder.com/100"),
    ]
    
    // MARK: - Public Methods
    
    /// 用户登录
    /// - Parameter request: 登录请求参数
    /// - Returns: 登录响应
    func login(request: LoginRequest) async throws -> APIResponse<LoginResponse> {
        // 模拟网络延迟
        try await Task.sleep(nanoseconds: UInt64(mockDelay * 1_000_000_000))
        
        // 查找用户
        if let user = mockUsers.first(where: { $0.email == request.email && $0.password == request.password }) {
            // 登录成功
            let response = LoginResponse(
                token: "mock_token_\(Int(Date().timeIntervalSince1970))",
                refreshToken: "mock_refresh_token_\(Int(Date().timeIntervalSince1970))",
                userId: user.userId,
                email: user.email,
                nickname: user.nickname,
                avatar: user.avatar,
                expiresIn: 7200
            )
            
            return APIResponse(code: 200, message: "登录成功", data: response)
        } else {
            // 登录失败
            return APIResponse(code: 401, message: "邮箱或密码错误", data: nil)
        }
    }
    
    /// 验证邮箱格式
    /// - Parameter email: 邮箱地址
    /// - Returns: 是否有效
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    /// 验证密码长度
    /// - Parameter password: 密码
    /// - Returns: 验证结果（valid: 是否有效, error: 错误信息）
    func validatePassword(_ password: String) -> (valid: Bool, error: String?) {
        if password.count < 6 {
            return (false, LoginErrorMessages[.passwordTooShort])
        }
        if password.count > 20 {
            return (false, LoginErrorMessages[.passwordTooLong])
        }
        return (true, nil)
    }
}
