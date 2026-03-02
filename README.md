# iOS 登录应用

## 项目概述
基于 SwiftUI 实现的企业级登录应用，支持多端联调。

## 技术栈
- **语言**: Swift 5.9+
- **UI 框架**: SwiftUI
- **最低支持版本**: iOS 15.0+
- **架构模式**: MVVM

## 功能特性
- 用户登录（用户名/密码）
- 表单验证
- 加载状态提示
- 错误处理
- Mock 数据联调支持

## 项目结构
```
ios-login-app/
├── App/
│   ├── LoginApp.swift          # 应用入口
│   ├── ContentView.swift       # 根视图
├── Features/
│   ├── Login/
│   │   ├── Views/
│   │   │   ├── LoginView.swift         # 登录页面
│   │   │   ├── LoginButton.swift       # 登录按钮组件
│   │   │   └── LoginInputField.swift   # 输入框组件
│   │   ├── ViewModels/
│   │   │   └── LoginViewModel.swift    # 登录视图模型
│   │   └── Models/
│   │       ├── LoginRequest.swift      # 登录请求模型
│   │       └── LoginResponse.swift     # 登录响应模型
│   └── Home/
│       └── Views/
│           └── HomeView.swift          # 首页
├── Services/
│   └── APIService.swift                # API 服务（支持 Mock）
└── Resources/
    └── Assets.xcassets/                # 图片资源
```

## 开发说明
- 使用 Xcode 15+ 打开项目
- 命令行运行：`xcodebuild -scheme ios-login-app -destination 'platform=iOS Simulator,name=iPhone 15' build`
- 运行测试：`xcodebuild test`

## 组件映射
- 通用按钮 -> SwiftUI `Button`
- 通用输入框 -> SwiftUI `TextField`
- 通用图片 -> SwiftUI `Image`

## 生成说明
本项目由自动化工作流生成，基于以下输入：
- 需求文档：GitHub Issue
- 设计稿：MasterGo（通过 Magic MCP 集成）
- API 定义：Postman Collection
