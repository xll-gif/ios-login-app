# Button 组件使用规则

## 组件说明

通用登录按钮组件，基于设计稿样式实现。

## 设计稿样式规范

- **背景色**: `#007AFF`（蓝色）
- **文字颜色**: `#FFFFFF`（白色）
- **圆角**: `4pt`
- **宽度**: `300pt`（可根据容器调整）
- **高度**: `44pt`（固定）
- **文字大小**: `16pt`
- **文字粗细**: `Medium (500)`

## API 文档

### 构造函数

```swift
Button(
    _ title: String,
    variant: ButtonVariant = .primary,
    isEnabled: Bool = true,
    width: CGFloat? = nil,
    height: CGFloat = 44,
    action: @escaping () -> Void
)
```

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|-----|------|--------|------|
| `title` | `String` | - | 按钮文字（必填） |
| `variant` | `ButtonVariant` | `.primary` | 按钮样式变体 |
| `isEnabled` | `Bool` | `true` | 是否可用 |
| `width` | `CGFloat?` | `nil` | 按钮宽度，nil 表示自适应 |
| `height` | `CGFloat` | `44` | 按钮高度（建议保持默认） |
| `action` | `() -> Void` | - | 点击事件回调（必填） |

### ButtonVariant 枚举

| 值 | 说明 | 背景色 | 文字颜色 | 边框 |
|---|---|---|---|---|
| `.primary` | 主要按钮（默认） | `#007AFF` | `#FFFFFF` | 无 |
| `.secondary` | 次要按钮 | `#FFFFFF` | `#007AFF` | `#007AFF` (1pt) |
| `.danger` | 危险按钮 | `#FF3B30` | `#FFFFFF` | 无 |

## 使用规则

### 1. 主要操作按钮

用于主要操作，如登录、提交、确认等。

```swift
Button("登录", action: {
    // 处理登录逻辑
})
.frame(width: 300)
```

### 2. 次要操作按钮

用于次要操作，如取消、返回等。

```swift
Button("取消", variant: .secondary, action: {
    // 处理取消逻辑
})
.frame(width: 300)
```

### 3. 危险操作按钮

用于危险操作，如退出登录、删除等。

```swift
Button("退出登录", variant: .danger, action: {
    // 处理退出逻辑
})
.frame(width: 300)
```

### 4. 禁用状态

当按钮处于禁用状态时，自动应用禁用样式。

```swift
Button("登录", isEnabled: false, action: {
    // 不会触发
})
.frame(width: 300)
```

### 5. 宽度设置

- **固定宽度**: 使用 `.frame(width: 300)` 设置固定宽度
- **自适应宽度**: 不设置 `width` 参数，按钮会自适应容器宽度
- **建议**: 登录页面的操作按钮建议使用固定宽度 `300pt`

### 6. 高度设置

- 按钮高度固定为 `44pt`，符合 iOS 设计规范
- 除非有特殊需求，否则不建议修改高度

## 禁止事项

1. ❌ 不要使用非设计稿规范的颜色
2. ❌ 不要修改按钮高度（除非有特殊需求）
3. ❌ 不要在按钮文字中使用特殊符号（如图标）
4. ❌ 不要嵌套按钮
5. ❌ 不要同时使用 `.secondary` 和 `.danger` 变体

## 布局建议

### 垂直布局

```swift
VStack(spacing: 20) {
    Button("登录", action: {})
        .frame(width: 300)
    
    Button("注册", variant: .secondary, action: {})
        .frame(width: 300)
}
.padding()
```

### 水平布局

```swift
HStack(spacing: 16) {
    Button("取消", variant: .secondary, action: {})
    
    Button("确认", action: {})
}
.frame(maxWidth: .infinity)
.padding()
```

## 可访问性

- 按钮文字应简洁明了，不超过 6 个汉字
- 避免使用纯符号或表情符号作为按钮文字
- 禁用状态应有明确的视觉反馈

## 版本历史

- v1.0.0 (2026-02-27): 初始版本，基于设计稿创建
