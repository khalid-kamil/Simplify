
import SwiftUI
import CoreData

extension Calendar {
    func numberOfDaysToGenerate(from date: Date) -> Int {
        let startDate = startOfDay(for: date)
        let futureDate = Calendar.current.date(byAdding: .day, value: 10, to: startDate)!
        let endDate = startOfDay(for: futureDate)
        let numberOfDays = dateComponents([.day], from: startDate, to: endDate)
        return numberOfDays.day!
    }
}

extension Date {
    var startDateOfMonth: Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else {
            print("Unable to get start date from date")
            return nil
        }
        return date
    }

    var endDateOfMonth: Date? {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startDateOfMonth!) else {
            print("Unable to get end date from date")
            return nil
        }
        return date
    }
}

struct TodayView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var userSettings: UserSettings
    @StateObject var vm = TodayViewModel()

    let calendar = Calendar.current

    // MARK: Fetching Habit
    @FetchRequest var habits: FetchedResults<Habit>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \LogItem.date, ascending: false)],
        animation: .default
    ) private var logItems: FetchedResults<LogItem>

    init() {
        let habitRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        habitRequest.predicate = nil
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
            let startDate = calendar.startOfDay(for: vm.today)
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
            logItems.nsPredicate = NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [startDate, endDate])
            if logItems.isEmpty {
                let logDays = calendar.numberOfDaysToGenerate(from: startDate)
                for day in (0...logDays) {
                    let logItem = LogItem(context: viewContext)
                    logItem.date = calendar.date(byAdding: .day, value: day, to: vm.today)
                }
                try? viewContext.save()
            }
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
            Text("Welcome back")
                .font(.callout)
                .fontWeight(.semibold)
            Text("Here are today's updates")
                .font(.title2.bold())
        }
        .padding(.vertical)
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
            Button {
                vm.today = Calendar.current.date(byAdding: .day, value: -1, to: vm.today)!
            } label: {
                Image(systemName: "chevron.left")
            }
            Text(vm.today.formatted(date: .abbreviated, time: .omitted))
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(vm.habitFound(in: habits) ? Color(habits.first!.color) : Color(vm.habitColor))
                .onTapGesture {
                    vm.today = Date()
                }
            Button {
                vm.today = Calendar.current.date(byAdding: .day, value: 1, to: vm.today)!
                let startDate = calendar.startOfDay(for: vm.today)
                let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
                logItems.nsPredicate = NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [startDate, endDate])
                if logItems.isEmpty {
                    let logDays = calendar.numberOfDaysToGenerate(from: startDate)
                    for day in (0...logDays) {
                        let logItem = LogItem(context: viewContext)
                        logItem.date = calendar.date(byAdding: .day, value: day, to: vm.today)
                    }
                    try? viewContext.save()
                }
            } label: {
                Image(systemName: "chevron.right")
            }
            if vm.habitFound(in: habits) {
                Button {
                    vm.editHabit = habits.first
                    vm.openEditHabit = true
                    vm.setupEditHabit()
                } label: {
                    Text("Edit")
                }
                .padding(.leading)
            }
        }
        .font(.headline)
        .fontWeight(.medium)
        .foregroundColor(vm.habitFound(in: habits) ? Color(habits.first!.color) : Color(vm.habitColor))
    }

    var habitSectionBody: some View {
        // MARK: Habit View
        ZStack {
            if vm.habitFound(in: habits) {
                HabitView(habit: habits.first!)
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
        VStack {
            Image(systemName: "plus.circle")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 2)
            Text("Create habit".uppercased())
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(Color(vm.habitColor))
        .onTapGesture {
            vm.openEditHabit.toggle()
        }
    }
}
