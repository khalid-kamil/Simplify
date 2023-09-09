
import SwiftUI
import CoreData

struct TodayView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var userSettings: UserSettings
    @StateObject var vm = TodayViewModel()

    let calendar = Calendar.current

    // MARK: Fetching Habit
    @FetchRequest var habits: FetchedResults<Habit>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \LogItem.date, ascending: true)],
        animation: .default
    ) private var logItems: FetchedResults<LogItem>

    init() {
        let habitRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        habitRequest.predicate = NSPredicate(format: "currentStreak <= %i", 28)
        habitRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \Habit.creationDate, ascending: false)
        ]
        habitRequest.fetchLimit = 1
        _habits = FetchRequest(fetchRequest: habitRequest)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    welcomeBack
                    habitSection
                    tasksSection
                }
                .padding()
            }
            .navigationTitle("1 Habit, 3 Tasks")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $vm.openEditHabit) {
            if vm.editHabit == nil {
                vm.resetHabitData()
            }
            vm.editHabit = nil
        } content: {
            AddHabitView()
                .environmentObject(vm)
        }
        .onAppear {
            vm.today = Calendar.current.startOfDay(for: Date())
            logItems.nsPredicate = vm.logItemPredicate
            vm.loadLogItem(from: logItems, in: viewContext)
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static let userSettings = UserSettings()
    static var previews: some View {
        TodayView()
            .environmentObject(userSettings)
    }
}

extension TodayView {
    var welcomeBack: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(vm.today.formatted(date: .long, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            Text("Today")
                .font(.largeTitle.bold())
        }
        .padding(.bottom)
    }

    var habitSection: some View {
        VStack(spacing: 8) {
            habitSectionHeader
            habitSectionBody
        }
        .padding(.bottom)
    }

    var habitSectionHeader: some View {
        HStack(alignment: .center) {
            Text("Habit")
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            if let currentHabit = vm.currentLogItem?.toHabit {
                Button {
                    vm.editHabit = currentHabit
                    vm.openEditHabit = true
                    vm.setupEditHabit()
                } label: {
                    Text("Edit")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color(currentHabit.color))
                }
                .padding(.leading)
            }
        }

    }

    var habitSectionBody: some View {
        // MARK: Habit View
        ZStack {
            if let currentHabit = vm.currentLogItem?.toHabit {
                HabitView(habit: currentHabit)
                    .environmentObject(vm)
            } else {
                createHabit
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 180)
        .background(.thinMaterial)
        .cornerRadius(12)
    }

    var tasksSection: some View {
        VStack {
            Section {
                Text("Task 1")
                    .foregroundColor(userSettings.task1Color)
                Text("Task 2")
                    .foregroundColor(userSettings.task2Color)
                Text("Task 3")
                    .foregroundColor(userSettings.task3Color)
            } header: {
                Text("Tasks")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .padding(.bottom)
    }

    var createHabit: some View {
        HStack {
            Image(systemName: "plus.circle")
                .font(.title2)
                .fontWeight(.bold)
            Text("New habit".uppercased())
                .font(.title2)
                .fontWeight(.semibold)
        }
        .foregroundColor(.gray)
        .onTapGesture {
            vm.openEditHabit.toggle()
        }
    }
}
