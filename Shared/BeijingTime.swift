import Foundation

enum BeijingTime {
    static let timeZoneIdentifier = "Asia/Shanghai"
    static let localeIdentifier = "zh_CN"

    static let timeZone: TimeZone = {
        TimeZone(identifier: timeZoneIdentifier)
            ?? TimeZone(secondsFromGMT: 8 * 60 * 60)
            ?? .current
    }()

    static let calendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = timeZone
        cal.locale = Locale(identifier: localeIdentifier)
        return cal
    }()

    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: localeIdentifier)
        f.timeZone = timeZone
        f.dateFormat = "HH:mm"
        return f
    }()

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: localeIdentifier)
        f.timeZone = timeZone
        f.dateFormat = "yyyy年M月d日 EEEE"
        return f
    }()

    static func timeString(from date: Date) -> String {
        timeFormatter.string(from: date)
    }

    static func dateString(from date: Date) -> String {
        dateFormatter.string(from: date)
    }

    // 本地时区随系统实时变化，不能缓存 formatter
    static func localTimeString(from date: Date) -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: localeIdentifier)
        f.timeZone = .current
        f.dateFormat = "HH:mm"
        return f.string(from: date)
    }

    static func minuteStart(for date: Date) -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)) ?? date
    }

    static func timelineDates(from date: Date, minuteCount: Int) -> [Date] {
        let startDate = minuteStart(for: date)
        return (0..<minuteCount).compactMap { offset in
            calendar.date(byAdding: .minute, value: offset, to: startDate)
        }
    }
}
