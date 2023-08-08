//
//  TodayView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct Habit {
  let target: Int = 28
  let milestones: [Int] = [1, 2, 3, 5, 7, 10, 14, 21]
  let creationDate: Date = Date()
  var currentStreak: Int = 0
  var isCompleted: Bool = false
  var isReminderOn: Bool = false

  var name: String

  var currentMilestoneIndex: Int = 0

  var targetAchieved: Bool {
    return currentStreak == target
  }

  mutating func newDay() {
    if !isCompleted {
      currentStreak = 0
      currentMilestoneIndex = 0
    } else {
      if currentStreak == milestones[currentMilestoneIndex] && currentMilestoneIndex + 1 < milestones.count {
        currentMilestoneIndex += 1
      }
    }
    isCompleted = false
  }
}

struct TodayView: View {
  @EnvironmentObject var userSettings: UserSettings
  @State var today = Date()
  @State var habit = Habit(name: "Pray Fajr on time at masjid")

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading) {
          Text("Habit")
            .font(.title2)
            .fontWeight(.semibold)
          HabitView(habit: $habit)

          Section {
            ForEach(1..<4) {
              Text("Task \($0)")
                .foregroundColor(userSettings.task1Color)
            }
          } header: {
            Text("Tasks")
              .font(.title2)
              .fontWeight(.semibold)
          }

          Section {

          } header: {
            Text("Journal")
              .font(.title2)
              .fontWeight(.semibold)
          }
        }
        .padding()
      }
      .navigationTitle("Today")
      .toolbar {
        ToolbarItem {
          Button {
            // Change day
            today = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            habit.newDay()
          } label: {
            Text(today.formatted(date: .abbreviated, time: .omitted))
          }
        }
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
