import SwiftUI

struct MenuBarClockLabel: View {
    var body: some View {
        TimelineView(.everyMinute) { context in
            Text(BeijingTime.timeString(from: context.date))
                .monospacedDigit()
        }
    }
}
