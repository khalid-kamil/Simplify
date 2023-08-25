
import SwiftUI

struct TodayView: View {
    @EnvironmentObject var userSettings: UserSettings
    @StateObject var vm = TodayViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    habitSection
                    tasksSection
                    journalSection
                }
                .padding()
            }
            .navigationTitle("Today")
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
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            Button {
                vm.nextDay()
            } label: {
                Text(vm.today.formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(userSettings.habitColor)
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
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
        .padding(.bottom)
    }

    var journalSection: some View {
        Section {

        } header: {
            Text("Journal")
                .font(.title2)
                .fontWeight(.semibold)
        }
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
        .foregroundColor(userSettings.habitColor)
        .onTapGesture {
            // TODO: Display add new habit sheet
            vm.addHabit(name: "Complete 30 mins of touch typing")
        }
    }
}
