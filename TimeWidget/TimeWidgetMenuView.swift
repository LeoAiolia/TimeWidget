import AppKit
import SwiftUI

struct TimeWidgetMenuView: View {
    @ObservedObject var clock: BeijingTimeClock

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            timeBlock
            Divider().padding(.vertical, 12)
            localTimeRow
            Divider().padding(.vertical, 10)
            quitButton
        }
        .padding(16)
        .frame(width: 240)
        .onAppear { clock.refresh() }
    }

    private var header: some View {
        Label("北京时间", systemImage: "clock")
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.secondary)
            .padding(.bottom, 10)
    }

    private var timeBlock: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(BeijingTime.timeString(from: clock.now))
                .font(.system(size: 48, weight: .thin, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(.primary)

            Text(BeijingTime.dateString(from: clock.now))
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }

    private var localTimeRow: some View {
        HStack {
            Text("本地时间")
                .foregroundStyle(.secondary)
            Spacer()
            Text(BeijingTime.localTimeString(from: clock.now))
                .monospacedDigit()
                .foregroundStyle(.primary)
        }
        .font(.subheadline)
    }

    private var quitButton: some View {
        Button {
            NSApplication.shared.terminate(nil)
        } label: {
            Text("退出")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
    }
}
