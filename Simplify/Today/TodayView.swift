
import SwiftUI

struct TodayView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var userSettings: UserSettings
    @StateObject var vm = TodayViewModel()

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
            vm.resetHabitData()
        } content: {
            AddHabitView()
                .environmentObject(vm)
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
        HStack(alignment: .bottom) {
            Text("Habit")
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            Button {

            } label: {
                Text(vm.today.formatted(date: .abbreviated, time: .omitted))
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color(vm.habitColor))
            }
        }
    }

    var habitSectionBody: some View {
        ZStack {
            if vm.targetAchieved {
                VStack {
                    Text("Congratulations")
                    createHabit
                }
            } else if vm.habitCreated {
                HabitView(vm: vm)
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
