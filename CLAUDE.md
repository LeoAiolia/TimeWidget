# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

macOS 菜单栏北京时间 + 桌面 WidgetKit 小组件。纯 Swift / SwiftUI，无第三方依赖。

## 构建与运行

```sh
# 构建
xcodebuild -project TimeWidget.xcodeproj -scheme TimeWidget -configuration Debug -derivedDataPath ./DerivedData build

# 运行（构建后）
open DerivedData/Build/Products/Debug/TimeWidget.app
```

App 使用 `LSUIElement`，不会出现 Dock 图标，运行后直接在菜单栏查看效果。

桌面小组件在 macOS 桌面小组件编辑界面搜索"北京时间"后添加，支持小号和中号。

## 架构

```
TimeWidget/          # 主 App target（菜单栏）
  TimeWidgetApp.swift        # @main，MenuBarExtra Scene
  MenuBarClockLabel.swift    # 菜单栏图标 Label，每分钟刷新
  TimeWidgetMenuView.swift   # 菜单展开后的详情面板

Shared/
  BeijingTime.swift          # 唯一业务逻辑：时区、格式化、timeline 生成

BeijingTimeWidget/   # Widget Extension target
  BeijingTimeWidgetBundle.swift  # @main WidgetBundle
  BeijingTimeWidget.swift        # Provider + Entry + 小号/中号 View
```

**核心约定：**

- `BeijingTime`（`Shared/`）是唯一的时间计算层，两个 target 共享同一份文件，禁止在 View 层重复格式化逻辑。
- WidgetKit timeline 由 `BeijingTime.timelineDates(from:minuteCount:)` 生成，每次预生成 24×60 条 entry，策略为 `.atEnd`。
- 菜单栏与 Widget 均使用 `TimelineView(.everyMinute)` 驱动 UI 刷新，不使用 Timer。
- 时区固定为 `Asia/Shanghai`，locale 固定为 `zh_CN`；`BeijingTime.timeZone` 有 fallback（`secondsFromGMT: 8 * 60 * 60`）。
