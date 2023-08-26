
import SwiftUI

struct SummaryView: View {
    @StateObject var tracker = Tracker.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tracker.database, id: \.date) { entry in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                            Text(entry.habit.name)
                            Text("\(entry.habit.currentStreak)")
                        }
                        Spacer()
                        Image(systemName: entry.habit.isCompleted ? "checkmark.circle" : "xmark.circle")
                            .foregroundColor(entry.habit.isCompleted ? .green : .red)
                    }

                }
            }
            .navigationTitle("Summary")
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
