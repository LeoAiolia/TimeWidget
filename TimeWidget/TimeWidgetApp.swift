import SwiftUI

@main
struct TimeWidgetApp: App {
    var body: some Scene {
        MenuBarExtra {
            TimeWidgetMenuView()
        } label: {
            MenuBarClockLabel()
        }
        .menuBarExtraStyle(.menu)
    }
}
