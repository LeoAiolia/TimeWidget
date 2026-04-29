import AppKit
import SwiftUI

struct TimeWidgetMenuView: View {
    @State private var now = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("北京时间")
                .font(.headline)

            Text(BeijingTime.timeString(from: now))
                .font(.system(size: 28, weight: .semibold, design: .rounded))
                .monospacedDigit()

            Text(BeijingTime.dateString(from: now))
                .font(.caption)
                .foregroundStyle(.secondary)

            Divider()

            Text("本地时间 \(BeijingTime.localTimeString(from: now))")
                .font(.caption)
                .foregroundStyle(.secondary)

            Button("退出") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding(.vertical, 6)
        .frame(minWidth: 180, alignment: .leading)
        .onReceive(
            Timer.publish(every: 30, on: .main, in: .common).autoconnect()
        ) { date in
            now = date
        }
    }
}
