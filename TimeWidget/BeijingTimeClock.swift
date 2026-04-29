import Combine
import Foundation

final class BeijingTimeClock: ObservableObject {
    @Published private(set) var now: Date

    private var timer: Timer?

    init(now: Date = Date()) {
        self.now = now
    }

    func start() {
        refresh()
        scheduleNextMinuteTick()
    }

    func refresh() {
        now = Date()
    }

    private func scheduleNextMinuteTick() {
        timer?.invalidate()
        let interval = Self.secondsUntilNextMinute(from: now)
        let t = Timer(timeInterval: interval, repeats: false) { [weak self] _ in
            self?.refresh()
            self?.scheduleNextMinuteTick()
        }
        timer = t
        RunLoop.main.add(t, forMode: .common)
    }

    private static func secondsUntilNextMinute(from date: Date) -> TimeInterval {
        let cal = BeijingTime.calendar
        let minuteStart = cal.date(
            from: cal.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        ) ?? date
        let nextMinute = cal.date(byAdding: .minute, value: 1, to: minuteStart)
            ?? date.addingTimeInterval(60)
        return max(0.2, nextMinute.timeIntervalSince(date) + 0.05)
    }
}
