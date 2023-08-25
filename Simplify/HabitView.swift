//
//  HabitView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct HabitView: View {
    @EnvironmentObject var userSettings: UserSettings
    @ObservedObject var vm: TodayViewModel

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                notificationBell
                habitName
                Spacer()
                markHabitAsCompletedButton
            }
            Spacer()
            circularProgressView
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static let userSettings = UserSettings()
    static var previews: some View {
        HabitView(vm: TodayViewModel())
            .environmentObject(userSettings)
            .previewDisplayName("Habit View Light")
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(height: 180)
    }
}

extension HabitView {
    var notificationBell: some View {
        Image(systemName: vm.isReminderOn ? "bell.fill" : "bell.slash")
            .onTapGesture {
                vm.toggleReminder()
                // TODO: Enable notifications
                // TODO: Trigger haptic feedback
            }
            .rotationEffect(.degrees(vm.isReminderOn ? -30 : 0), anchor: .top)
            .animation(.interpolatingSpring(stiffness: 200, damping: 6), value: vm.isReminderOn)
            .foregroundColor(userSettings.habitColor)
    }

    var habitName: some View {
        Text(vm.habitName)
            .font(.title3)
            .fontWeight(.medium)
    }

    var markHabitAsCompletedButton: some View {
        Button {
            vm.markHabitAsCompleted()
        } label: {
            HStack(spacing: 4) {
                Image(systemName: vm.habitIsCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                Text(vm.habitIsCompleted ? "Done!" : "Mark as done")
            }
            .fontWeight(.semibold)
        }
        .buttonStyle(.bordered)
        .tint(userSettings.habitColor)
        .disabled(vm.habitIsCompleted)
    }

    var circularProgressView: some View {
        CircularProgressView(value: vm.currentStreak, target: vm.nextMilestone, color: userSettings.habitColor)
            .padding()
    }
}
