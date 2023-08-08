//
//  HabitView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct HabitView: View {
  @EnvironmentObject var userSettings: UserSettings
  @Binding var habit: Habit

  var body: some View {
    HStack(alignment: .top) {
      VStack(alignment: .leading, spacing: 4) {
        Image(systemName: habit.isReminderOn ? "bell.fill" : "bell.slash")
          .onTapGesture {
            habit.isReminderOn.toggle()
            // TODO: Enable notifications
            // TODO: Trigger haptic feedback
          }
          .rotationEffect(.degrees(habit.isReminderOn ? -30 : 0), anchor: .top)
          .animation(.interpolatingSpring(stiffness: 200, damping: 6), value: habit.isReminderOn)
          .foregroundColor(userSettings.habitColor)
        Text(habit.name)
          .font(.title3)
          .fontWeight(.medium)
        Spacer()
        Button {
          habit.currentStreak += 1
          habit.isCompleted = true
        } label: {
          HStack(spacing: 4) {
            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
            Text(habit.isCompleted ? "Done!" : "Mark as done")
          }
          .fontWeight(.semibold)
        }
        .buttonStyle(.bordered)
        .tint(userSettings.habitColor)
        .disabled(habit.isCompleted)
      }
      Spacer()
      CircularProgressView(value: habit.currentStreak, target: habit.milestones[habit.currentMilestoneIndex], color: userSettings.habitColor)
        .padding()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: 180)
    .background(.thinMaterial)
    .cornerRadius(12)
  }
}

struct HabitView_Previews: PreviewProvider {
  static let userSettings = UserSettings()
  static var previews: some View {
    HabitView(habit: .constant(Habit(name: "Sample Habit")))
      .environmentObject(userSettings)
      .previewDisplayName("Habit View Light")
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
