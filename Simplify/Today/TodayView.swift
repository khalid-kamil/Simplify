//
//  TodayView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

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
