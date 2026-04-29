import SwiftUI
import WidgetKit

struct BeijingTimeEntry: TimelineEntry {
    let date: Date
}

struct BeijingTimeProvider: TimelineProvider {
    func placeholder(in context: Context) -> BeijingTimeEntry {
        BeijingTimeEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (BeijingTimeEntry) -> Void) {
        completion(BeijingTimeEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<BeijingTimeEntry>) -> Void) {
        let entries = BeijingTime.timelineDates(from: Date(), minuteCount: 24 * 60)
            .map { BeijingTimeEntry(date: $0) }
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct BeijingTimeWidgetEntryView: View {
    let entry: BeijingTimeEntry

    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        switch widgetFamily {
        case .systemMedium:
            MediumBeijingTimeView(entry: entry)
        case .systemSmall:
            SmallBeijingTimeView(entry: entry)
        default:
            SmallBeijingTimeView(entry: entry)
        }
    }
}

struct SmallBeijingTimeView: View {
    let entry: BeijingTimeEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("北京时间", systemImage: "clock")
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)

            Spacer(minLength: 0)

            Text(BeijingTime.timeString(from: entry.date))
                .font(.system(size: 38, weight: .semibold, design: .rounded))
                .monospacedDigit()
                .minimumScaleFactor(0.75)

            Text(BeijingTime.dateString(from: entry.date))
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .containerBackground(for: .widget) {
            Color(red: 0.08, green: 0.09, blue: 0.11)
        }
    }
}

struct MediumBeijingTimeView: View {
    let entry: BeijingTimeEntry

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Label("北京时间", systemImage: "clock")
                    .font(.callout.weight(.medium))
                    .foregroundStyle(.secondary)

                Text(BeijingTime.dateString(from: entry.date))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)

            Text(BeijingTime.timeString(from: entry.date))
                .font(.system(size: 48, weight: .semibold, design: .rounded))
                .monospacedDigit()
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .containerBackground(for: .widget) {
            Color(red: 0.08, green: 0.09, blue: 0.11)
        }
    }
}

struct BeijingTimeWidget: Widget {
    let kind = "BeijingTimeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: BeijingTimeProvider()) { entry in
            BeijingTimeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("北京时间")
        .description("显示分钟级北京时间。")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
