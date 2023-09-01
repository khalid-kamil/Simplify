
import SwiftUI

struct SummaryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \LogItem.date, ascending: false)],
        animation: .default)
    private var logItems: FetchedResults<LogItem>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(logItems) { entry in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(entry.date?.formatted() ?? "Unknown")
                            Text(entry.toHabit?.wrappedName ?? "hi")
                            Text("\(entry.toHabit?.currentStreak ?? 99)")
                        }
                        Spacer()
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
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
