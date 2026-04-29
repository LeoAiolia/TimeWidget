import Foundation

enum BeijingTime {
    static let timeZoneIdentifier = "Asia/Shanghai"
    static let localeIdentifier = "zh_CN"

    static let timeZone: TimeZone = {
        if let timeZone = TimeZone(identifier: timeZoneIdentifier) {
            return timeZone
        }

        return TimeZone(secondsFromGMT: 8 * 60 * 60) ?? .current
    }()

    static func timeString(from date: Date) -> String {
        string(from: date, format: "HH:mm")
    }

    static func dateString(from date: Date) -> String {
        string(from: date, format: "yyyy年M月d日 EEEE")
    }

    static func localTimeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.timeZone = .current
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    static func minuteStart(for date: Date) -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)) ?? date
    }

    static func timelineDates(from date: Date, minuteCount: Int) -> [Date] {
        let startDate = minuteStart(for: date)
        return (0..<minuteCount).compactMap { minuteOffset in
            calendar.date(byAdding: .minute, value: minuteOffset, to: startDate)
        }
    }

    private static var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        calendar.locale = Locale(identifier: localeIdentifier)
        return calendar
    }

    private static func string(from date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.timeZone = timeZone
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
