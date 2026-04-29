import AppKit
import Combine
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private let clock = BeijingTimeClock()
    private var clockCancellable: AnyCancellable?

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        setupButton()
        setupPopover()
        bindClock()
        clock.start()
    }

    private func setupButton() {
        guard let button = statusItem.button else { return }
        button.font = .monospacedDigitSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
        updateButtonTitle(for: clock.now)
        button.action = #selector(togglePopover)
        button.target = self
    }

    private func setupPopover() {
        popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: TimeWidgetMenuView(clock: clock))
    }

    private func bindClock() {
        clockCancellable = clock.$now.sink { [weak self] date in
            self?.updateButtonTitle(for: date)
        }
    }

    private func updateButtonTitle(for date: Date) {
        statusItem.button?.title = BeijingTime.timeString(from: date)
    }

    @objc private func togglePopover() {
        guard let button = statusItem.button else { return }
        if popover.isShown {
            popover.performClose(nil)
            return
        }
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        repositionPopover(relativeTo: button)
    }

    private func repositionPopover(relativeTo button: NSButton) {
        guard let buttonWindow = button.window,
              let popoverWindow = popover.contentViewController?.view.window else { return }
        let buttonInScreen = buttonWindow.convertToScreen(button.convert(button.bounds, to: nil))
        let x = buttonInScreen.midX - popoverWindow.frame.width / 2
        let y = buttonInScreen.minY - popoverWindow.frame.height
        popoverWindow.setFrameOrigin(NSPoint(x: x, y: y))
        popoverWindow.makeKey()
    }
}
