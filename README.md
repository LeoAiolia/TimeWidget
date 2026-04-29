# TimeWidget

macOS 菜单栏北京时间和桌面小组件。

## 功能

- 菜单栏显示分钟级北京时间。
- 菜单展开后显示北京时间日期、本地时间和退出入口。
- WidgetKit 小组件支持小号和中号尺寸，显示分钟级北京时间。

## 构建

```sh
xcodebuild -project TimeWidget.xcodeproj -scheme TimeWidget -configuration Debug -derivedDataPath ./DerivedData build
```

## 运行

```sh
open DerivedData/Build/Products/Debug/TimeWidget.app
```

运行后菜单栏会出现北京时间。因为 App 使用 `LSUIElement`，不会显示 Dock 图标。

## 添加桌面小组件

运行 App 后，打开 macOS 桌面小组件编辑界面，搜索“北京时间”，选择小号或中号组件添加到桌面。
