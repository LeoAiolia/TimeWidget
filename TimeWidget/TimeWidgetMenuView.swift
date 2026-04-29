import AppKit
import SwiftUI

struct TimeWidgetMenuView: View {
    var body: some View {
        TimelineView(.everyMinute) { context in
            VStack(alignment: .leading, spacing: 8) {
                Text("北京时间")
                    .font(.headline)

                Text(BeijingTime.timeString(from: context.date))
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .monospacedDigit()

                Text(BeijingTime.dateString(from: context.date))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Divider()

                Text("本地时间 \(BeijingTime.localTimeString(from: context.date))")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Button("退出") {
                    NSApplication.shared.terminate(nil)
                }
            }
            .padding(.vertical, 6)
            .frame(minWidth: 180, alignment: .leading)
        }
    }
}
