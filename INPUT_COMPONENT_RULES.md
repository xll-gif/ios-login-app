# InputField 组件使用规则

## 组件说明

通用输入框组件，基于设计稿样式实现。

## 设计稿样式规范

- **边框颜色**: `#DDDDDD`（浅灰色）
- **边框宽度**: `1pt`
- **圆角**: `4pt`
- **宽度**: `300pt`（可根据容器调整）
- **高度**: `40pt`（固定）
- **文字大小**: `16pt`
- **文字颜色**: `#333333`
- **占位符颜色**: `#999999`
- **内边距**: `12pt`

## API 文档

### 构造函数

```swift
InputField(
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
)
```

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|-----|------|--------|------|
| `title` | `String?` | `nil` | 输入框标题 |
| `placeholder` | `String` | - | 占位符（必填） |
| `text` | `Binding<String>` | - | 输入值绑定（必填） |
| `keyboardType` | `UIKeyboardType` | `.default` | 键盘类型 |
| `isSecureTextEntry` | `Bool` | `false` | 是否密码输入 |
| `isEnabled` | `Bool` | `true` | 是否启用 |
| `isError` | `isError` | `false` | 是否有错误 |
| `errorMessage` | `String?` | `nil` | 错误提示 |
| `width` | `CGFloat?` | `nil` | 输入框宽度，nil 表示自适应 |
| `height` | `CGFloat` | `40` | 输入框高度（建议保持默认） |
| `padding` | `CGFloat` | `12` | 内边距 |

### UIKeyboardType 类型

| 值 | 说明 |
|---|------|
| `.default` | 默认键盘 |
| `.emailAddress` | 邮箱地址 |
| `.phonePad` | 电话号码 |
| `.numberPad` | 数字键盘 |
| `.decimalPad` | 小数键盘 |
| `.URL` | 网址 |

## 使用规则

### 1. 基础输入框

```swift
@State private var email = ""

InputField(
    placeholder: "请输入邮箱",
    text: $email,
    keyboardType: .emailAddress
)
.frame(width: 300)
```

### 2. 带标题的输入框

```swift
@State private var password = ""

InputField(
    title: "密码",
    placeholder: "请输入密码",
    text: $password,
    isSecureTextEntry: true
)
.frame(width: 300)
```

### 3. 错误状态

```swift
@State private var email = ""
@State private var isError = false

InputField(
    title: "邮箱",
    placeholder: "请输入邮箱",
    text: $email,
    isError: isError,
    errorMessage: "邮箱格式不正确"
)
.frame(width: 300)
```

### 4. 禁用状态

```swift
@State private var disabledText = "已禁用"

InputField(
    placeholder: "禁用状态",
    text: $disabledText,
    isEnabled: false
)
.frame(width: 300)
```

### 5. 手机号输入

```swift
@State private var phone = ""

InputField(
    title: "手机号",
    placeholder: "请输入手机号",
    text: $phone,
    keyboardType: .phonePad
)
.frame(width: 300)
```

### 6. 数字输入

```swift
@State private var amount = ""

InputField(
    title: "金额",
    placeholder: "请输入金额",
    text: $amount,
    keyboardType: .decimalPad
)
.frame(width: 300)
```

## 布局建议

### 垂直表单布局

```swift
VStack(spacing: 20) {
    InputField(
        title: "邮箱",
        placeholder: "请输入邮箱",
        text: $email,
        keyboardType: .emailAddress
    )
    .frame(width: 300)
    
    InputField(
        title: "密码",
        placeholder: "请输入密码",
        text: $password,
        isSecureTextEntry: true
    )
    .frame(width: 300)
}
.padding()
```

### 错误验证流程

```swift
func validateEmail() -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailPred.evaluate(with: email)
}

func handleSubmit() {
    if !validateEmail() {
        isError = true
        errorMessage = "邮箱格式不正确"
    } else {
        // 提交逻辑
    }
}
```

## 禁止事项

1. ❌ 不要使用非设计稿规范的颜色
2. ❌ 不要修改输入框高度（除非有特殊需求）
3. ❌ 不要在占位符中使用特殊符号
4. ❌ 不要嵌套输入框
5. ❌ 不要同时使用错误状态和禁用状态（除非业务需要）

## 可访问性

- 输入框标题应简洁明了，不超过 4 个汉字
- 占位符应清晰说明输入内容
- 错误提示应准确描述问题
- 支持键盘自动弹出和收起

## 版本历史

- v1.0.0 (2026-02-27): 初始版本，基于设计稿创建
